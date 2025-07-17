<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<!-- Root template -->
<xsl:template match="/recipeml">
  <html lang="{@xml:lang}">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <title>
        <xsl:choose>
          <xsl:when test="recipe">
            <xsl:value-of select="recipe/head/title"/>
          </xsl:when>
          <xsl:when test="menu">
            <xsl:value-of select="menu/head/title"/>
          </xsl:when>
          <xsl:otherwise>RecipeML Document</xsl:otherwise>
        </xsl:choose>
      </title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
      <script src="https://unpkg.com/lucide@latest"></script>
      <style>
        .fraction { display: inline-block; vertical-align: middle; }
        .fraction .numerator { display: block; text-align: center; border-bottom: 1px solid #000; }
        .fraction .denominator { display: block; text-align: center; }
        .recipe-meta { background: #f8f9fa; border-radius: 8px; padding: 1rem; margin-bottom: 1.5rem; }
        .nutrition-table td { padding: 0.25rem 0.5rem; }
        .equipment-list { background: #fff3cd; border-radius: 6px; padding: 1rem; margin-bottom: 1rem; }
        .step-duration { font-size: 0.875rem; color: #6c757d; font-style: italic; }
        .optional-ingredient { opacity: 0.8; font-style: italic; }
        .brandname { font-weight: 500; color: #0d6efd; }
        .tool-reference { background: #e3f2fd; padding: 0.125rem 0.375rem; border-radius: 4px; font-size: 0.875rem; }
        .ingredient-reference { background: #e8f5e8; padding: 0.125rem 0.375rem; border-radius: 4px; font-size: 0.875rem; }
        .prep-note { color: #6c757d; font-style: italic; }
        .category-badge { background: #6f42c1; color: white; }
      </style>
    </head>
    <body class="bg-light">
      <div class="container py-5">
        <xsl:apply-templates select="menu | recipe"/>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <script>
        // Initialize Lucide icons
        lucide.createIcons();
      </script>
    </body>
  </html>
</xsl:template>

<!-- Menu template -->
<xsl:template match="menu">
  <div class="row">
    <div class="col-lg-10 mx-auto">
      <article class="card shadow-sm">
        <div class="card-body">
          <xsl:apply-templates select="head"/>
          <xsl:apply-templates select="description"/>
          
          <div class="row">
            <xsl:for-each select="recipe">
              <div class="col-md-6 col-lg-4 mb-4">
                <div class="card h-100">
                  <div class="card-body">
                    <h5 class="card-title">
                      <xsl:value-of select="head/title"/>
                    </h5>
                    <xsl:if test="head/categories">
                      <div class="mb-2">
                        <xsl:for-each select="head/categories/cat">
                          <span class="badge bg-secondary me-1">
                            <xsl:value-of select="."/>
                          </span>
                        </xsl:for-each>
                      </div>
                    </xsl:if>
                    <xsl:if test="head/preptime">
                      <p class="text-muted">
                        <i data-lucide="clock" class="me-1" style="width: 16px; height: 16px;"></i>
                        <xsl:apply-templates select="head/preptime[1]"/>
                      </p>
                    </xsl:if>
                  </div>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </article>
    </div>
  </div>
</xsl:template>

<!-- Recipe template -->
<xsl:template match="recipe">
  <div class="row">
    <div class="col-lg-8 mx-auto">
      <article class="card shadow-sm">
        <div class="card-body">
          <xsl:apply-templates select="head"/>
          <xsl:apply-templates select="description"/>
          <xsl:apply-templates select="equipment"/>
          <xsl:apply-templates select="ingredients"/>
          <xsl:apply-templates select="directions"/>
          <xsl:apply-templates select="nutrition"/>
          <xsl:apply-templates select="diet-exchanges"/>
        </div>
      </article>
    </div>
  </div>
</xsl:template>

<!-- Head section -->
<xsl:template match="head">
  <header class="mb-4">
    <h1 class="card-title text-center mb-3">
      <xsl:value-of select="title"/>
    </h1>
    
    <xsl:if test="subtitle">
      <h2 class="h5 text-center text-muted mb-3">
        <xsl:value-of select="subtitle"/>
      </h2>
    </xsl:if>
    
    <!-- Metadata row -->
    <div class="recipe-meta">
      <div class="row g-3">
        <xsl:if test="preptime">
          <div class="col-md-4">
            <div class="d-flex align-items-center">
              <i data-lucide="timer" class="me-2"></i>
              <div>
                <div class="fw-bold">Prep Times</div>
                <xsl:for-each select="preptime">
                  <div class="small">
                    <xsl:value-of select="@type"/>: <xsl:apply-templates select="."/>
                  </div>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </xsl:if>
        
        <xsl:if test="yield">
          <div class="col-md-4">
            <div class="d-flex align-items-center">
              <i data-lucide="utensils" class="me-2"></i>
              <div>
                <div class="fw-bold">Yield</div>
                <div><xsl:apply-templates select="yield"/></div>
              </div>
            </div>
          </div>
        </xsl:if>
        
        <xsl:if test="version">
          <div class="col-md-4">
            <div class="d-flex align-items-center">
              <i data-lucide="git-branch" class="me-2"></i>
              <div>
                <div class="fw-bold">Version</div>
                <div><xsl:value-of select="version"/></div>
              </div>
            </div>
          </div>
        </xsl:if>
      </div>
    </div>

    <!-- Categories -->
    <xsl:if test="categories">
      <div class="mb-3">
        <xsl:for-each select="categories/cat">
          <span class="badge category-badge me-2">
            <i data-lucide="tag" class="me-1" style="width: 14px; height: 14px;"></i>
            <xsl:value-of select="."/>
            <xsl:if test="@type"> (<xsl:value-of select="@type"/>)</xsl:if>
          </span>
        </xsl:for-each>
      </div>
    </xsl:if>

    <!-- Source information -->
    <xsl:if test="source">
      <div class="text-muted small">
        <div class="d-flex align-items-center">
          <i data-lucide="book-open" class="me-1" style="width: 16px; height: 16px;"></i>
          Source: <xsl:apply-templates select="source"/>
        </div>
      </div>
    </xsl:if>
  </header>
</xsl:template>

<!-- Description -->
<xsl:template match="description">
  <div class="alert alert-light border-start border-4 border-info mb-4">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- Equipment section -->
<xsl:template match="equipment">
  <section class="mb-4">
    <h2 class="h4 mb-3 d-flex align-items-center">
      <i data-lucide="wrench" class="me-2"></i>
      Equipment
    </h2>
    <div class="equipment-list">
      <xsl:choose>
        <xsl:when test="equip-div">
          <xsl:apply-templates select="equip-div"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="note"/>
          <ul class="list-unstyled mb-0">
            <xsl:for-each select="tool">
              <li class="mb-2">
                <i data-lucide="tool" class="me-2" style="width: 16px; height: 16px;"></i>
                <xsl:apply-templates select="."/>
                <xsl:if test="@optional = 'yes'"> (optional)</xsl:if>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </section>
</xsl:template>

<xsl:template match="equip-div">
  <div class="mb-3">
    <xsl:if test="title">
      <h5><xsl:value-of select="title"/></h5>
    </xsl:if>
    <xsl:apply-templates select="description"/>
    <xsl:apply-templates select="note"/>
    <ul class="list-unstyled">
      <xsl:for-each select="tool">
        <li class="mb-1">
          <i data-lucide="tool" class="me-2" style="width: 16px; height: 16px;"></i>
          <xsl:apply-templates select="."/>
          <xsl:if test="@optional = 'yes'"> (optional)</xsl:if>
        </li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>

<!-- Ingredients section -->
<xsl:template match="ingredients">
  <section class="mb-4">
    <h2 class="h4 mb-3 d-flex align-items-center">
      <i data-lucide="shopping-basket" class="me-2"></i>
      Ingredients
    </h2>
    <xsl:choose>
      <xsl:when test="ing-div">
        <xsl:apply-templates select="ing-div"/>
      </xsl:when>
      <xsl:otherwise>
        <div class="card">
          <ul class="list-group list-group-flush">
            <xsl:apply-templates select="note | ing"/>
          </ul>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </section>
</xsl:template>

<xsl:template match="ing-div">
  <div class="card mb-3">
    <xsl:if test="title">
      <div class="card-header">
        <h5 class="mb-0"><xsl:value-of select="title"/></h5>
      </div>
    </xsl:if>
    <xsl:if test="description">
      <div class="card-body py-2">
        <xsl:apply-templates select="description"/>
      </div>
    </xsl:if>
    <ul class="list-group list-group-flush">
      <xsl:apply-templates select="note | ing"/>
    </ul>
  </div>
</xsl:template>

<xsl:template match="ing">
  <li class="list-group-item">
    <xsl:if test="@optional = 'yes'">
      <xsl:attribute name="class">list-group-item optional-ingredient</xsl:attribute>
    </xsl:if>
    <div class="d-flex align-items-start">
      <i data-lucide="chevron-right" class="me-2 mt-1" style="width: 16px; height: 16px;"></i>
      <div class="flex-grow-1">
        <xsl:apply-templates select="amt"/>
        <xsl:if test="modifier">
          <xsl:text> </xsl:text>
          <span class="text-muted"><xsl:apply-templates select="modifier"/></span>
        </xsl:if>
        <xsl:text> </xsl:text>
        <span class="fw-medium"><xsl:apply-templates select="item"/></span>
        <xsl:if test="prep">
          <xsl:text>, </xsl:text>
          <span class="prep-note"><xsl:apply-templates select="prep"/></span>
        </xsl:if>
        <xsl:if test="@optional = 'yes'">
          <span class="badge bg-light text-dark ms-2">optional</span>
        </xsl:if>
        <xsl:if test="ing-note">
          <div class="small text-muted mt-1">
            <xsl:for-each select="ing-note">
              <div><xsl:apply-templates select="."/></div>
            </xsl:for-each>
          </div>
        </xsl:if>
        <xsl:if test="alt-ing">
          <div class="small text-info mt-1">
            <strong>Alternatives:</strong>
            <xsl:for-each select="alt-ing">
              <div class="ms-2">
                <xsl:apply-templates select="amt"/>
                <xsl:if test="modifier">
                  <xsl:text> </xsl:text>
                  <xsl:apply-templates select="modifier"/>
                </xsl:if>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="item"/>
                <xsl:if test="prep">
                  <xsl:text>, </xsl:text>
                  <xsl:apply-templates select="prep"/>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>
        </xsl:if>
      </div>
    </div>
  </li>
</xsl:template>

<!-- Directions section -->
<xsl:template match="directions">
  <section class="mb-4">
    <h2 class="h4 mb-3 d-flex align-items-center">
      <i data-lucide="clipboard-list" class="me-2"></i>
      Directions
    </h2>
    <xsl:choose>
      <xsl:when test="dir-div">
        <xsl:apply-templates select="dir-div"/>
      </xsl:when>
      <xsl:otherwise>
        <ol class="list-group list-group-numbered">
          <xsl:apply-templates select="note | ing | step"/>
        </ol>
      </xsl:otherwise>
    </xsl:choose>
  </section>
</xsl:template>

<xsl:template match="dir-div">
  <div class="card mb-3">
    <xsl:if test="title">
      <div class="card-header">
        <h5 class="mb-0">
          <xsl:value-of select="title"/>
          <xsl:if test="@duration">
            <span class="step-duration ms-2">
              (Duration: <xsl:value-of select="@duration"/>)
            </span>
          </xsl:if>
        </h5>
      </div>
    </xsl:if>
    <xsl:if test="description">
      <div class="card-body py-2">
        <xsl:apply-templates select="description"/>
      </div>
    </xsl:if>
    <ol class="list-group list-group-numbered">
      <xsl:apply-templates select="note | ing | step"/>
    </ol>
  </div>
</xsl:template>

<xsl:template match="step">
  <li class="list-group-item">
    <xsl:if test="@optional = 'yes'">
      <xsl:attribute name="class">list-group-item optional-ingredient</xsl:attribute>
    </xsl:if>
    <div class="d-flex justify-content-between align-items-start">
      <div class="flex-grow-1">
        <xsl:apply-templates/>
        <xsl:if test="@optional = 'yes'">
          <span class="badge bg-light text-dark ms-2">optional</span>
        </xsl:if>
      </div>
      <xsl:if test="@duration">
        <span class="step-duration ms-2">
          <i data-lucide="clock" class="me-1" style="width: 14px; height: 14px;"></i>
          <xsl:value-of select="@duration"/>
        </span>
      </xsl:if>
    </div>
    <xsl:if test="substep">
      <ol class="list-group list-group-numbered mt-2" type="a">
        <xsl:for-each select="substep">
          <li class="list-group-item">
            <xsl:apply-templates select="."/>
            <xsl:if test="@duration">
              <span class="step-duration ms-2">
                (<xsl:value-of select="@duration"/>)
              </span>
            </xsl:if>
          </li>
        </xsl:for-each>
      </ol>
    </xsl:if>
  </li>
</xsl:template>

<!-- Nutrition section -->
<xsl:template match="nutrition">
  <section class="mb-4">
    <h2 class="h4 mb-3 d-flex align-items-center">
      <i data-lucide="heart" class="me-2"></i>
      Nutrition Information
      <xsl:if test="@standard">
        <span class="badge bg-info ms-2"><xsl:value-of select="@standard"/></span>
      </xsl:if>
    </h2>
    <div class="card">
      <div class="card-body">
        <xsl:choose>
          <xsl:when test="nutrient-group">
            <xsl:apply-templates select="nutrient-group"/>
          </xsl:when>
          <xsl:otherwise>
            <table class="table table-sm nutrition-table">
              <tbody>
                <xsl:apply-templates select="nutrient"/>
              </tbody>
            </table>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </section>
</xsl:template>

<xsl:template match="nutrient-group">
  <div class="mb-4">
    <xsl:if test="title">
      <h5><xsl:value-of select="title"/></h5>
    </xsl:if>
    <table class="table table-sm nutrition-table">
      <tbody>
        <xsl:apply-templates select="nutrient"/>
      </tbody>
    </table>
  </div>
</xsl:template>

<xsl:template match="nutrient">
  <tr>
    <td class="fw-medium">
      <xsl:value-of select="n-name[1]"/>
      <xsl:if test="n-name[@alternate='yes']">
        <span class="text-muted small">
          (<xsl:for-each select="n-name[@alternate='yes']">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>)
        </span>
      </xsl:if>
    </td>
    <td class="text-end">
      <xsl:choose>
        <xsl:when test="qty">
          <xsl:apply-templates select="qty"/>
          <xsl:if test="unit">
            <xsl:text> </xsl:text>
            <xsl:value-of select="unit"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="percent">
          <xsl:apply-templates select="percent"/>%
        </xsl:when>
      </xsl:choose>
    </td>
  </tr>
</xsl:template>

<!-- Diet exchanges section -->
<xsl:template match="diet-exchanges">
  <section class="mb-4">
    <h2 class="h4 mb-3 d-flex align-items-center">
      <i data-lucide="repeat" class="me-2"></i>
      Diet Exchanges
      <xsl:if test="@authority">
        <span class="badge bg-success ms-2"><xsl:value-of select="@authority"/></span>
      </xsl:if>
    </h2>
    <div class="card">
      <div class="card-body">
        <div class="row g-2">
          <xsl:for-each select="exchange">
            <div class="col-md-6">
              <div class="border rounded p-2">
                <xsl:apply-templates select="."/>
              </div>
            </div>
          </xsl:for-each>
        </div>
      </div>
    </div>
  </section>
</xsl:template>

<!-- Notes handling -->
<xsl:template match="note">
  <xsl:choose>
    <xsl:when test="parent::directions or parent::dir-div or parent::ingredients or parent::ing-div or parent::equipment or parent::equip-div">
      <li class="list-group-item bg-light">
        <div class="d-flex align-items-start">
          <i data-lucide="info" class="me-2 mt-1" style="width: 16px; height: 16px;"></i>
          <div>
            <xsl:if test="@type">
              <strong><xsl:value-of select="@type"/>:</strong>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </div>
        </div>
      </li>
    </xsl:when>
    <xsl:otherwise>
      <div class="alert alert-info">
        <div class="d-flex align-items-start">
          <i data-lucide="info" class="me-2 mt-1"></i>
          <div>
            <xsl:if test="@type">
              <h6 class="alert-heading"><xsl:value-of select="@type"/></h6>
            </xsl:if>
            <xsl:apply-templates/>
          </div>
        </div>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Source handling -->
<xsl:template match="source">
  <xsl:choose>
    <xsl:when test="srcitem">
      <xsl:for-each select="srcitem">
        <div>
          <xsl:if test="@type">
            <strong><xsl:value-of select="@type"/>:</strong>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:apply-templates select="."/>
        </div>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Measurement templates -->
<xsl:template match="amt">
  <span class="fw-bold">
    <xsl:apply-templates select="qty | range"/>
    <xsl:if test="size">
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="size"/>
    </xsl:if>
    <xsl:if test="unit">
      <xsl:text> </xsl:text>
      <xsl:value-of select="unit"/>
    </xsl:if>
  </span>
</xsl:template>

<xsl:template match="qty">
  <xsl:choose>
    <xsl:when test="frac">
      <xsl:apply-templates select="text()[1]"/>
      <xsl:apply-templates select="frac"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="range">
  <xsl:apply-templates select="q1"/>
  <xsl:choose>
    <xsl:when test="sep">
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="sep"/>
      <xsl:text> </xsl:text>
    </xsl:when>
    <xsl:otherwise>-</xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates select="q2"/>
</xsl:template>

<xsl:template match="q1 | q2">
  <xsl:choose>
    <xsl:when test="frac">
      <xsl:apply-templates select="text()[1]"/>
      <xsl:apply-templates select="frac"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="frac">
  <span class="fraction">
    <span class="numerator"><xsl:value-of select="n"/></span>
    <span class="denominator"><xsl:value-of select="d"/></span>
  </span>
</xsl:template>

<xsl:template match="time">
  <xsl:apply-templates select="qty | range"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="timeunit"/>
</xsl:template>

<xsl:template match="temp">
  <xsl:apply-templates select="qty | range"/>
  <xsl:text>°</xsl:text>
  <xsl:value-of select="tempunit"/>
</xsl:template>

<xsl:template match="steptime">
  <span class="step-duration">
    <i data-lucide="clock" class="me-1" style="width: 14px; height: 14px;"></i>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- Action elements in steps -->
<xsl:template match="action">
  <strong><xsl:apply-templates/></strong>
</xsl:template>

<xsl:template match="condition">
  <em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="setting">
  <span class="badge bg-warning text-dark">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- References -->
<xsl:template match="toolref">
  <span class="tool-reference">
    <i data-lucide="tool" class="me-1" style="width: 12px; height: 12px;"></i>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="ingref">
  <span class="ingredient-reference">
    <i data-lucide="leaf" class="me-1" style="width: 12px; height: 12px;"></i>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- Brand names -->
<xsl:template match="brandname">
  <span class="brandname">
    <xsl:choose>
      <xsl:when test="mfr and product">
        <xsl:apply-templates select="mfr"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="product"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </span>
</xsl:template>

<xsl:template match="mfr">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="product">
  <xsl:apply-templates/>
</xsl:template>

<!-- Utility elements -->
<xsl:template match="sep">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="span">
  <span>
    <xsl:if test="@class">
      <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@title">
      <xsl:attribute name="title"><xsl:value-of select="@title"/></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="size">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="percent">
  <xsl:choose>
    <xsl:when test="frac">
      <xsl:apply-templates select="text()[1]"/>
      <xsl:apply-templates select="frac"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
