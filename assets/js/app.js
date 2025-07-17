// RecipeML Implementation - Static Website JavaScript
// Handles file upload, XML parsing, and XSL transformation

document.addEventListener('DOMContentLoaded', function() {
    const uploadArea = document.getElementById('uploadArea');
    const fileInput = document.getElementById('fileInput');
    const fileStatus = document.getElementById('fileStatus');
    const renderResult = document.getElementById('renderResult');

    // Drag and drop handlers
    uploadArea.addEventListener('dragover', handleDragOver);
    uploadArea.addEventListener('dragleave', handleDragLeave);
    uploadArea.addEventListener('drop', handleDrop);
    uploadArea.addEventListener('click', () => fileInput.click());
    fileInput.addEventListener('change', handleFileSelect);

    function handleDragOver(e) {
        e.preventDefault();
        uploadArea.classList.add('dragover');
    }

    function handleDragLeave(e) {
        e.preventDefault();
        uploadArea.classList.remove('dragover');
    }

    function handleDrop(e) {
        e.preventDefault();
        uploadArea.classList.remove('dragover');
        
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            processFile(files[0]);
        }
    }

    function handleFileSelect(e) {
        const files = e.target.files;
        if (files.length > 0) {
            processFile(files[0]);
        }
    }

    function processFile(file) {
        // Validate file type
        if (!file.name.toLowerCase().endsWith('.xml')) {
            showStatus('error', 'Please select an XML file.');
            return;
        }

        showStatus('info', `Processing ${file.name}...`);

        const reader = new FileReader();
        reader.onload = function(e) {
            try {
                const xmlContent = e.target.result;
                
                // Basic XML validation
                const parser = new DOMParser();
                const xmlDoc = parser.parseFromString(xmlContent, 'text/xml');
                
                // Check for parsing errors
                const parseError = xmlDoc.getElementsByTagName('parsererror');
                if (parseError.length > 0) {
                    showStatus('error', 'Invalid XML format. Please check your file.');
                    return;
                }

                // Check if it's a RecipeML document
                const recipeml = xmlDoc.getElementsByTagName('recipeml');
                if (recipeml.length === 0) {
                    showStatus('warning', 'This doesn\'t appear to be a RecipeML document.');
                }

                // Apply XSL transformation
                transformAndRender(xmlContent, file.name);

            } catch (error) {
                showStatus('error', `Error processing file: ${error.message}`);
                console.error('File processing error:', error);
            }
        };

        reader.onerror = function() {
            showStatus('error', 'Error reading file.');
        };

        reader.readAsText(file);
    }

    async function transformAndRender(xmlContent, fileName) {
        try {
            // Load the XSL stylesheet
            const xslResponse = await fetch('xsl/recipe.xsl');
            if (!xslResponse.ok) {
                throw new Error('Could not load XSL stylesheet');
            }
            const xslContent = await xslResponse.text();

            // Parse XML and XSL
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(xmlContent, 'text/xml');
            const xslDoc = parser.parseFromString(xslContent, 'text/xml');

            // Perform XSL transformation
            const xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xslDoc);
            const resultDoc = xsltProcessor.transformToFragment(xmlDoc, document);

            // Display results
            showStatus('success', `Successfully rendered ${fileName}`);
            showRenderResult(resultDoc);

        } catch (error) {
            showStatus('error', `Transformation error: ${error.message}`);
            console.error('XSL transformation error:', error);
            
            // Fallback: show raw XML in a formatted way
            showRawXml(xmlContent, fileName);
        }
    }

    function showRawXml(xmlContent, fileName) {
        const container = document.createElement('div');
        container.innerHTML = `
            <div class="alert alert-warning">
                <h6><i class="lucide-alert-triangle me-2"></i>XSL Transformation Failed</h6>
                <p>Showing raw XML content instead. This may happen due to browser security restrictions when loading local files.</p>
                <p><strong>Tip:</strong> Try serving this page via HTTP/HTTPS or open the XML file directly in your browser.</p>
            </div>
            <div class="card">
                <div class="card-header">
                    <h6>Raw XML: ${fileName}</h6>
                </div>
                <div class="card-body">
                    <pre class="bg-light p-3 rounded"><code>${escapeHtml(xmlContent)}</code></pre>
                </div>
            </div>
        `;
        showRenderResult(container);
    }

    function showStatus(type, message) {
        const statusClass = {
            'success': 'alert-success',
            'error': 'alert-danger',
            'warning': 'alert-warning',
            'info': 'alert-info'
        }[type] || 'alert-info';

        const iconClass = {
            'success': 'check-circle',
            'error': 'x-circle',
            'warning': 'alert-triangle',
            'info': 'info'
        }[type] || 'info';

        fileStatus.innerHTML = `
            <div class="alert ${statusClass} d-flex align-items-center">
                <i data-lucide="${iconClass}" class="me-2"></i>
                ${message}
            </div>
        `;
        fileStatus.style.display = 'block';
        
        // Re-initialize Lucide icons for new content
        lucide.createIcons();
    }

    function showRenderResult(content) {
        renderResult.innerHTML = '';
        
        // Create container with proper styling
        const container = document.createElement('div');
        container.className = 'border rounded p-3 bg-white';
        
        if (content.nodeType === Node.DOCUMENT_FRAGMENT_NODE) {
            container.appendChild(content);
        } else {
            container.appendChild(content);
        }
        
        renderResult.appendChild(container);
        renderResult.style.display = 'block';
        
        // Re-initialize Lucide icons for the rendered content
        lucide.createIcons();
        
        // Scroll to result
        renderResult.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add some interactive features to example cards
    document.querySelectorAll('.feature-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });

    // Browser compatibility check
    function checkBrowserCompatibility() {
        const features = {
            'XSLTProcessor': typeof XSLTProcessor !== 'undefined',
            'DOMParser': typeof DOMParser !== 'undefined',
            'FileReader': typeof FileReader !== 'undefined',
            'Fetch API': typeof fetch !== 'undefined'
        };

        const unsupported = Object.entries(features)
            .filter(([feature, supported]) => !supported)
            .map(([feature]) => feature);

        if (unsupported.length > 0) {
            const warningDiv = document.createElement('div');
            warningDiv.className = 'alert alert-warning mt-3';
            warningDiv.innerHTML = `
                <h6><i data-lucide="alert-triangle" class="me-2"></i>Browser Compatibility Warning</h6>
                <p>Some features may not work in your browser:</p>
                <ul class="mb-0">
                    ${unsupported.map(feature => `<li>${feature}</li>`).join('')}
                </ul>
                <p class="mt-2 mb-0">
                    <small>Consider using a modern browser like Chrome, Firefox, Safari, or Edge for the best experience.</small>
                </p>
            `;
            
            document.querySelector('.container').insertBefore(
                warningDiv, 
                document.querySelector('#examples')
            );
            
            lucide.createIcons();
        }
    }

    // Run compatibility check
    checkBrowserCompatibility();

    // Add copy-to-clipboard functionality for code blocks
    document.querySelectorAll('.code-block').forEach(block => {
        const copyBtn = document.createElement('button');
        copyBtn.className = 'btn btn-sm btn-outline-secondary position-absolute top-0 end-0 m-2';
        copyBtn.innerHTML = '<i data-lucide="copy" style="width: 14px; height: 14px;"></i>';
        copyBtn.title = 'Copy to clipboard';
        
        block.style.position = 'relative';
        block.appendChild(copyBtn);
        
        copyBtn.addEventListener('click', async () => {
            try {
                await navigator.clipboard.writeText(block.textContent.replace('Copy', '').trim());
                copyBtn.innerHTML = '<i data-lucide="check" style="width: 14px; height: 14px;"></i>';
                setTimeout(() => {
                    copyBtn.innerHTML = '<i data-lucide="copy" style="width: 14px; height: 14px;"></i>';
                    lucide.createIcons();
                }, 1000);
            } catch (err) {
                console.error('Failed to copy text: ', err);
            }
        });
    });

    // Initialize icons for dynamically added content
    setTimeout(() => lucide.createIcons(), 100);
});
