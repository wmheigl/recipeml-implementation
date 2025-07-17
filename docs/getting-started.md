# Getting Started with RecipeML

This guide will help you create your first RecipeML document and understand the basic concepts of the markup language.

## Prerequisites

- Basic understanding of XML
- A text editor or XML editor
- A modern web browser for viewing results

## Quick Setup

### Option 1: Using the Static Website
1. **Visit the testing interface** at the GitHub Pages URL
2. **Upload an XML file** or try the provided examples
3. **View the rendered output** immediately

### Option 2: Local Development
1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/recipeml-implementation.git
   cd recipeml-implementation
   ```

2. **Serve locally** (optional, for avoiding CORS issues):
   ```bash
   # Python 3
   python -m http.server 8000
   
   # Python 2
   python -m SimpleHTTPServer 8000
   
   # Node.js
   npx serve .
   ```

3. **Open in browser:**
   - Navigate to `http://localhost:8000` for the interface
   - Or open XML files directly from `examples/`

## Your First Recipe

Let's create a simple chocolate chip cookie recipe step by step.

### Step 1: Document Structure

Every RecipeML document starts with these required elements:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE recipeml PUBLIC "-//FormatData//DTD RecipeML 0.5//EN" "dtd/recipeml.dtd">
<recipeml version="0.5" xml:lang="en">
  <!-- Your content goes here -->
</recipeml>
```

### Step 2: Add Recipe Wrapper

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE recipeml PUBLIC "-//FormatData//DTD RecipeML 0.5//EN" "dtd/recipeml.dtd">
<recipeml version="0.5" xml:lang="en">
  <recipe>
    <!-- Recipe content goes here -->
  </recipe>
</recipeml>
```

### Step 3: Add Recipe Header

```xml
<recipe>
  <head>
    <title>Simple Chocolate Chip Cookies</title>
    <categories>
      <cat type="course">dessert</cat>
      <cat type="cuisine">American</cat>
    </categories>
    <preptime type="total">
      <time>
        <qty>30</qty>
        <timeunit>minutes</timeunit>
      </time>
    </preptime>
    <yield>
      <qty>24</qty>
      <unit>cookies</unit>
    </yield>
  </head>
  <!-- More content to follow -->
</recipe>
```

### Step 4: Add Ingredients

```xml
<ingredients>
  <ing>
    <amt>
      <qty>2</qty>
      <unit>cups</unit>
    </amt>
    <item>all-purpose flour</item>
  </ing>
  
  <ing>
    <amt>
      <qty>1</qty>
      <unit>tsp</unit>
    </amt>
    <item>baking soda</item>
  </ing>
  
  <ing>
    <amt>
      <qty>1</qty>
      <unit>tsp</unit>
    </amt>
    <item>salt</item>
  </ing>
  
  <ing>
    <amt>
      <qty>1</qty>
      <unit>cup</unit>
    </amt>
    <item>butter</item>
    <prep>softened</prep>
  </ing>
  
  <ing>
    <amt>
      <qty><frac><n>3</n><d>4</d></frac></qty>
      <unit>cup</unit>
    </amt>
    <item>brown sugar</item>
  </ing>
  
  <ing>
    <amt>
      <qty><frac><n>1</n><d>2</d></frac></qty>
      <unit>cup</unit>
    </amt>
    <item>white sugar</item>
  </ing>
  
  <ing>
    <amt>
      <qty>2</qty>
      <unit>large</unit>
    </amt>
    <item>eggs</item>
  </ing>
  
  <ing>
    <amt>
      <qty>2</qty>
      <unit>tsp</unit>
    </amt>
    <item>vanilla extract</item>
  </ing>
  
  <ing>
    <amt>
      <qty>2</qty>
      <unit>cups</unit>
    </amt>
    <item>chocolate chips</item>
  </ing>
</ingredients>
```

### Step 5: Add Directions

```xml
<directions>
  <step>
    Preheat oven to <temp><qty>375</qty><tempunit unit="F">°F</tempunit></temp>.
  </step>
  
  <step>
    In a medium bowl, <action>whisk together</action> flour, baking soda, and salt.
  </step>
  
  <step>
    In a large bowl, <action>cream</action> butter and both sugars until 
    <condition>light and fluffy</condition>.
  </step>
  
  <step>
    <action>Beat in</action> eggs one at a time, then vanilla.
  </step>
  
  <step>
    <action>Gradually mix in</action> flour mixture until just combined.
  </step>
  
  <step>
    <action>Stir in</action> chocolate chips.
  </step>
  
  <step>
    <action>Drop</action> rounded tablespoons of dough onto ungreased baking sheets.
  </step>
  
  <step duration="12 minutes">
    <action>Bake</action> for 10-12 minutes until <condition>edges are golden brown</condition>.
  </step>
  
  <step>
    <action>Cool</action> on baking sheet for 5 minutes, then transfer to wire rack.
  </step>
</directions>
```

### Complete Example

Here's the complete recipe:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE recipeml PUBLIC "-//FormatData//DTD RecipeML 0.5//EN" "dtd/recipeml.dtd">
<recipeml version="0.5" xml:lang="en">
  <recipe>
    <head>
      <title>Simple Chocolate Chip Cookies</title>
      <categories>
        <cat type="course">dessert</cat>
        <cat type="cuisine">American</cat>
      </categories>
      <preptime type="total">
        <time>
          <qty>30</qty>
          <timeunit>minutes</timeunit>
        </time>
      </preptime>
      <yield>
        <qty>24</qty>
        <unit>cookies</unit>
      </yield>
    </head>
    
    <ingredients>
      <ing>
        <amt><qty>2</qty><unit>cups</unit></amt>
        <item>all-purpose flour</item>
      </ing>
      <ing>
        <amt><qty>1</qty><unit>tsp</unit></amt>
        <item>baking soda</item>
      </ing>
      <ing>
        <amt><qty>1</qty><unit>tsp</unit></amt>
        <item>salt</item>
      </ing>
      <ing>
        <amt><qty>1</qty><unit>cup</unit></amt>
        <item>butter</item>
        <prep>softened</prep>
      </ing>
      <ing>
        <amt><qty><frac><n>3</n><d>4</d></frac></qty><unit>cup</unit></amt>
        <item>brown sugar</item>
      </ing>
      <ing>
        <amt><qty><frac><n>1</n><d>2</d></frac></qty><unit>cup</unit></amt>
        <item>white sugar</item>
      </ing>
      <ing>
        <amt><qty>2</qty><unit>large</unit></amt>
        <item>eggs</item>
      </ing>
      <ing>
        <amt><qty>2</qty><unit>tsp</unit></amt>
        <item>vanilla extract</item>
      </ing>
      <ing>
        <amt><qty>2</qty><unit>cups</unit></amt>
        <item>chocolate chips</item>
      </ing>
    </ingredients>
    
    <directions>
      <step>
        Preheat oven to <temp><qty>375</qty><tempunit unit="F">°F</tempunit></temp>.
      </step>
      <step>
        In a medium bowl, <action>whisk together</action> flour, baking soda, and salt.
      </step>
      <step>
        In a large bowl, <action>cream</action> butter and both sugars until 
        <condition>light and fluffy</condition>.
      </step>
      <step>
        <action>Beat in</action> eggs one at a time, then vanilla.
      </step>
      <step>
        <action>Gradually mix in</action> flour mixture until just combined.
      </step>
      <step>
        <action>Stir in</action> chocolate chips.
      </step>
      <step>
        <action>Drop</action> rounded tablespoons of dough onto ungreased baking sheets.
      </step>
      <step duration="12 minutes">
        <action>Bake</action> for 10-12 minutes until <condition>edges are golden brown</condition>.
      </step>
      <step>
        <action>Cool</action> on baking sheet for 5 minutes, then transfer to wire rack.
      </step>
    </directions>
  </recipe>
</recipeml>
```

## Testing Your Recipe

### Method 1: Direct Browser Opening
1. Save your XML file with a `.xml` extension
2. Open it directly in a modern web browser
3. The XSL transformation should apply automatically

### Method 2: Using the Static Website
1. Go to the testing interface
2. Drag and drop your XML file or click "Choose File"
3. View the rendered result immediately

### Method 3: XML Editor Validation
1. Use an XML editor like XMLSpy, Oxygen, or VS Code with XML extensions
2. Validate against the DTD: `dtd/recipeml.dtd`
3. Fix any validation errors before testing rendering

## Common Patterns

### Adding Fractions

Use the `<frac>` element for common cooking fractions:

```xml
<!-- 1½ cups -->
<qty>1<frac><n>1</n><d>2</d></frac></qty>

<!-- ¾ teaspoon -->
<qty><frac><n>3</n><d>4</d></frac></qty>

<!-- 2¼ pounds -->
<qty>2<frac><n>1</n><d>4</d></frac></qty>
```

### Adding Ranges

Use ranges for flexible measurements:

```xml
<!-- 3-4 tablespoons -->
<qty>
  <range>
    <q1>3</q1>
    <sep>to</sep>
    <q2>4</q2>
  </range>
</qty>

<!-- 8-10 minutes -->
<time>
  <qty>
    <range>
      <q1>8</q1>
      <q2>10</q2>
    </range>
  </qty>
  <timeunit>minutes</timeunit>
</time>
```

### Adding Equipment

Include equipment lists for complex recipes:

```xml
<equipment>
  <tool>Large mixing bowl</tool>
  <tool>Electric mixer</tool>
  <tool>Measuring cups and spoons</tool>
  <tool>Baking sheets</tool>
  <tool optional="yes">Cookie scoop</tool>
</equipment>
```

### Adding Notes

Include helpful tips and warnings:

```xml
<note type="Tip">
  For chewier cookies, slightly underbake and let them finish cooking on the hot pan.
</note>

<note type="Storage">
  Store in an airtight container for up to one week.
</note>

<note type="Variation">
  Try adding chopped nuts or dried fruit instead of chocolate chips.
</note>
```

## Advanced Features

### Multiple Preparation Times

Break down timing information:

```xml
<preptime type="preparation">
  <time><qty>15</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="baking">
  <time><qty>12</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="cooling">
  <time><qty>30</qty><timeunit>minutes</timeunit></time>
</preptime>
```

### Alternative Ingredients

Provide substitution options:

```xml
<ing>
  <amt><qty>1</qty><unit>cup</unit></amt>
  <item>chocolate chips</item>
  <alt-ing>
    <amt><qty>1</qty><unit>cup</unit></amt>
    <item>chopped walnuts</item>
  </alt-ing>
  <alt-ing>
    <amt><qty><frac><n>1</n><d>2</d></frac></qty><unit>cup</unit></amt>
    <item>chocolate chips</item>
    <amt><qty><frac><n>1</n><d>2</d></frac></qty><unit>cup</unit></amt>
    <item>chopped walnuts</item>
  </alt-ing>
</ing>
```

### Complex Directions

Use direction divisions for multi-part recipes:

```xml
<directions>
  <dir-div type="preparation">
    <title>Prepare Dough</title>
    <step>Mix dry ingredients.</step>
    <step>Cream butter and sugars.</step>
  </dir-div>
  
  <dir-div type="baking">
    <title>Bake Cookies</title>
    <step>Shape dough into balls.</step>
    <step>Bake until golden.</step>
  </dir-div>
</directions>
```

## Troubleshooting

### Common Issues

**Issue**: XML doesn't render in browser
- **Solution**: Check that the XSL reference is correct and the file is served via HTTP
- **Alternative**: Use the static website interface

**Issue**: DTD validation errors
- **Solution**: Ensure all required elements are present and properly nested
- **Check**: DOCTYPE declaration points to correct DTD file

**Issue**: Fractions not displaying correctly
- **Solution**: Verify `<frac><n>numerator</n><d>denominator</d></frac>` structure
- **Note**: The XSL stylesheet provides special fraction formatting

**Issue**: Categories or metadata not showing
- **Solution**: Check that elements are properly nested within `<head>` section
- **Verify**: Category type attributes are specified correctly

### Validation Tips

1. **Use an XML editor** with DTD validation support
2. **Check element nesting** - ingredients go in `<ingredients>`, steps in `<directions>`
3. **Verify required attributes** - some elements need type or other attributes
4. **Test incrementally** - start simple and add complexity gradually

## Next Steps

1. **Explore the examples** in the `examples/` folder
2. **Read the specification** in `docs/specification.md`
3. **Try advanced features** like nutrition information and equipment references
4. **Create a menu document** with multiple recipes
5. **Customize the XSL** stylesheet for your specific needs

## Getting Help

- Check the [specification document](specification.md) for detailed element reference
- Look at the [examples documentation](examples.md) for pattern explanations
- Open an issue on GitHub for bugs or questions
- Refer to the original RecipeML documentation at FormatData

Happy recipe markup!
