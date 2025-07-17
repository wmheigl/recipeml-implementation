# RecipeML 0.5 Specification Notes

## Overview

RecipeML (Recipe Markup Language) is an XML-based format for marking up recipes, originally created by FormatData in November 2000. This document provides implementation notes and clarifications for the RecipeML 0.5 specification.

## Document Structure

### Root Element
```xml
<recipeml version="0.5" xml:lang="en" generator="optional-tool-name">
  <!-- Content: meta*, (menu | recipe) -->
</recipeml>
```

### Metadata
Dublin Core metadata elements are supported:
```xml
<meta name="DC.Title" content="Recipe Title"/>
<meta name="DC.Creator" content="Author Name"/>
<meta name="DC.Date" content="2024-03-15"/>
<meta name="DC.Description" content="Recipe description"/>
<meta name="DC.Type" content="Recipe"/>
<meta name="DC.Subject" content="Keywords, tags"/>
```

## Recipe Structure

### Head Section
Every recipe must have a head section with at least a title:
```xml
<head>
  <title>Recipe Name</title>
  <subtitle>Optional subtitle</subtitle>
  <version>Recipe version</version>
  <source>Source information</source>
  <categories>Category information</categories>
  <preptime type="preparation">Time element</preptime>
  <yield>Serving information</yield>
</head>
```

### Categories
Categories can be structured or simple text:
```xml
<categories>
  <cat type="meal">dinner</cat>
  <cat type="course">main course</cat>
  <cat type="cuisine">Italian</cat>
</categories>
```

### Preparation Times
Multiple preparation times can be specified:
```xml
<preptime type="preparation">
  <time><qty>30</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="cooking">
  <time><qty>45</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="total">
  <time><qty>1</qty><timeunit>hour</timeunit></time>
</preptime>
```

## Ingredients Section

### Basic Ingredient
```xml
<ing>
  <amt><qty>2</qty><unit>cups</unit></amt>
  <item>all-purpose flour</item>
  <prep>sifted</prep>
</ing>
```

### Ingredient with Fractions
```xml
<ing>
  <amt>
    <qty>2<frac><n>1</n><d>4</d></frac></qty>
    <unit>cups</unit>
  </amt>
  <item>sugar</item>
</ing>
```

### Ingredient with Range
```xml
<ing>
  <amt>
    <qty>
      <range>
        <q1>3</q1>
        <sep>to</sep>
        <q2>4</q2>
      </range>
    </qty>
    <unit>tablespoons</unit>
  </amt>
  <item>olive oil</item>
</ing>
```

### Alternative Ingredients
```xml
<ing>
  <amt><qty>1</qty><unit>cup</unit></amt>
  <item>chocolate chips</item>
  <alt-ing>
    <amt><qty>1</qty><unit>cup</unit></amt>
    <item>chopped walnuts</item>
  </alt-ing>
</ing>
```

### Optional Ingredients
```xml
<ing optional="yes">
  <amt><qty>1</qty><unit>tsp</unit></amt>
  <item>vanilla extract</item>
</ing>
```

### Ingredient Divisions
```xml
<ingredients>
  <ing-div type="main">
    <title>Main Ingredients</title>
    <description>Primary recipe components</description>
    <!-- ingredients here -->
  </ing-div>
  <ing-div type="sauce">
    <title>Sauce</title>
    <!-- sauce ingredients here -->
  </ing-div>
</ingredients>
```

## Directions Section

### Basic Steps
```xml
<directions>
  <step>Preheat oven to 350°F.</step>
  <step>Mix dry ingredients in a large bowl.</step>
  <step duration="10 minutes">Bake until golden brown.</step>
</directions>
```

### Direction Divisions
```xml
<directions>
  <dir-div type="preparation">
    <title>Preparation</title>
    <step>Prepare ingredients</step>
  </dir-div>
  <dir-div type="cooking">
    <title>Cooking</title>
    <step>Cook the dish</step>
  </dir-div>
</directions>
```

### Sub-steps
```xml
<step>
  Prepare the dough:
  <substep>Mix flour and salt</substep>
  <substep>Add water gradually</substep>
</step>
```

### Step Elements
- **action**: `<action>Mix</action>` - cooking actions
- **condition**: `<condition>until golden</condition>` - cooking conditions
- **setting**: `<setting>medium heat</setting>` - equipment settings
- **toolref**: `<toolref toolid="mixer">stand mixer</toolref>` - tool references
- **ingref**: `<ingref ingid="flour">flour mixture</ingref>` - ingredient references
- **steptime**: `<steptime><time><qty>5</qty><timeunit>minutes</timeunit></time></steptime>` - timing

## Equipment Section

### Basic Equipment
```xml
<equipment>
  <tool>Large mixing bowl</tool>
  <tool optional="yes">Stand mixer</tool>
</equipment>
```

### Equipment Divisions
```xml
<equipment>
  <equip-div type="main">
    <title>Essential Equipment</title>
    <tool id="mixer">Stand mixer</tool>
    <tool>Large bowl</tool>
  </equip-div>
  <equip-div type="optional">
    <title>Optional Equipment</title>
    <tool optional="yes">Food processor</tool>
  </equip-div>
</equipment>
```

## Measurements and Units

### Temperature
```xml
<temp><qty>350</qty><tempunit unit="F">°F</tempunit></temp>
<temp><qty>175</qty><tempunit unit="C">°C</tempunit></temp>
```

### Time
```xml
<time><qty>30</qty><timeunit>minutes</timeunit></time>
<time><qty>1</qty><timeunit>hour</timeunit></time>
```

### Amounts with Size
```xml
<amt>
  <qty>6</qty>
  <size>large</size>
  <unit>eggs</unit>
</amt>
```

## Nutrition Information

### Basic Nutrition
```xml
<nutrition standard="USDV">
  <nutrient>
    <n-name>Calories</n-name>
    <qty>250</qty>
  </nutrient>
  <nutrient>
    <n-name>Total Fat</n-name>
    <qty>12</qty>
    <unit>g</unit>
    <percent>18</percent>
  </nutrient>
</nutrition>
```

### Nutrient Groups
```xml
<nutrition>
  <nutrient-group>
    <title>Macronutrients</title>
    <nutrient>
      <n-name>Protein</n-name>
      <qty>15</qty>
      <unit>g</unit>
    </nutrient>
  </nutrient-group>
</nutrition>
```

## Diet Exchanges

```xml
<diet-exchanges authority="American Diabetes Association">
  <exchange><qty>2</qty> Starch</exchange>
  <exchange><qty>1</qty> Fat</exchange>
</diet-exchanges>
```

## Notes and Descriptions

### Recipe-level Notes
```xml
<note type="Tip">
  For best results, use room temperature ingredients.
</note>
<note type="Storage">
  Store covered in refrigerator for up to 3 days.
</note>
```

### Section Descriptions
```xml
<description>
  This classic recipe has been in our family for generations.
  The secret is using high-quality ingredients and patience.
</description>
```

## Menu Documents

### Menu Structure
```xml
<menu>
  <head>
    <title>Holiday Dinner Menu</title>
    <categories>
      <cat type="occasion">holiday</cat>
    </categories>
  </head>
  <description>A complete holiday feast</description>
  
  <recipe>
    <!-- First course recipe -->
  </recipe>
  
  <recipe>
    <!-- Main course recipe -->
  </recipe>
  
  <recipe>
    <!-- Dessert recipe -->
  </recipe>
</menu>
```

## Brand Names and Product Codes

### Brand Names
```xml
<brandname>
  <mfr>Kraft</mfr>
  <product>Philadelphia Cream Cheese</product>
</brandname>
```

### Product Codes
```xml
<prodcode type="UPC" content="123456789012" domain="grocery-store"/>
```

## Best Practices

### 1. Use Semantic Markup
- Use `<action>` for cooking verbs
- Use `<condition>` for doneness tests
- Use `<setting>` for equipment settings

### 2. Structure Complex Recipes
- Use divisions for multi-part recipes
- Reference ingredients and tools with ID attributes
- Break complex steps into sub-steps

### 3. Include Metadata
- Add Dublin Core metadata for better cataloging
- Include source attribution
- Specify measurement systems

### 4. Handle Alternatives
- Use `<alt-ing>` for ingredient substitutions
- Mark optional ingredients and steps
- Provide notes for variations

### 5. Be Precise with Measurements
- Use fractions for common cooking measurements
- Include size descriptors (large eggs, medium onion)
- Specify temperature units clearly

## Implementation Notes

### DTD Validation
All elements and attributes in this implementation follow the RecipeML 0.5 DTD specification. Validate your documents against the DTD to ensure compliance.

### XSL Transformation
The provided XSL stylesheet handles all standard RecipeML elements and provides responsive, accessible HTML output with Bootstrap styling.

### Browser Compatibility
RecipeML documents with XSL processing instructions work in all modern browsers that support XSLT processing (Chrome, Firefox, Safari, Edge).

## References

- [Original RecipeML Specification](http://www.formatdata.com/recipeml/)
- [Dublin Core Metadata](http://purl.org/dc)
- [XML Specification](https://www.w3.org/XML/)
- [XSLT Specification](https://www.w3.org/TR/xslt/)
