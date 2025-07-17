# RecipeML Examples

This document explains the example files included in this implementation, highlighting key features and patterns demonstrated in each.

## Example Overview

| File | Recipe | Complexity | Key Features |
|------|--------|------------|--------------|
| `simple-recipe.xml` | Chocolate Chip Cookies | Basic | Fractions, ranges, basic structure |
| `complex-recipe.xml` | Beef Wellington | Advanced | Divisions, references, sub-steps |
| `menu-example.xml` | Spring Dinner Menu | Menu | Multiple recipes, course organization |

## Simple Recipe Example

**File**: `examples/simple-recipe.xml`  
**Recipe**: Classic Chocolate Chip Cookies

### Purpose
This example demonstrates the fundamental RecipeML concepts that every recipe should include. It's perfect for learning the basic structure and common patterns.

### Key Features Demonstrated

#### 1. Document Structure
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE recipeml PUBLIC "-//FormatData//DTD RecipeML 0.5//EN" "recipeml.dtd">
<recipeml version="0.5" xml:lang="en">
```
- Proper XML declaration and encoding
- DOCTYPE declaration referencing the DTD
- Root element with version and language

#### 2. Dublin Core Metadata
```xml
<meta name="DC.Title" content="Classic Chocolate Chip Cookies"/>
<meta name="DC.Creator" content="Jane Smith"/>
<meta name="DC.Date" content="2024-03-15"/>
<meta name="DC.Description" content="A traditional chocolate chip cookie recipe"/>
```
- Document cataloging information
- Author attribution
- Creation date tracking

#### 3. Recipe Head Structure
```xml
<head>
  <title>Classic Chocolate Chip Cookies</title>
  <subtitle>Grandma's Famous Recipe</subtitle>
  <version>2.1</version>
  <source>
    <srcitem type="DC.Creator">Jane Smith</srcitem>
    <srcitem type="DC.Publisher">Family Cookbook</srcitem>
    <srcitem type="DC.Date">1985</srcitem>
  </source>
```
- Title and subtitle for display
- Version tracking for recipe refinements
- Structured source attribution

#### 4. Categories and Classification
```xml
<categories>
  <cat type="course">dessert</cat>
  <cat type="cuisine">American</cat>
  <cat type="ingredient">chocolate</cat>
</categories>
```
- Typed categories for better organization
- Multiple classification dimensions

#### 5. Multiple Preparation Times
```xml
<preptime type="preparation">
  <time><qty>15</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="baking">
  <time><qty>12</qty><timeunit>minutes</timeunit></time>
</preptime>
```
- Separate timing for different phases
- Structured time elements with units

#### 6. Fractions in Measurements
```xml
<amt>
  <qty>2<frac><n>1</n><d>4</d></frac></qty>
  <unit>cups</unit>
</amt>
```
- Proper fraction markup (2¼ cups)
- Common cooking measurements

#### 7. Measurement Ranges
```xml
<amt>
  <qty>
    <range>
      <q1><frac><n>3</n><d>4</d></frac></q1>
      <sep>to</sep>
      <q2>1</q2>
    </range>
  </qty>
  <unit>cup</unit>
</amt>
```
- Flexible measurements (¾ to 1 cup)
- Custom separators ("to" instead of "-")

#### 8. Ingredient Preparation
```xml
<ing>
  <amt><qty>1</qty><unit>cup</unit></amt>
  <item>butter</item>
  <prep>softened</prep>
</ing>
```
- Preparation instructions for ingredients
- Clear specification of ingredient state

#### 9. Alternative Ingredients
```xml
<ing>
  <amt><qty>2</qty><unit>cups</unit></amt>
  <item>chocolate chips</item>
  <alt-ing>
    <amt><qty>2</qty><unit>cups</unit></amt>
    <item>chopped walnuts</item>
  </alt-ing>
  <alt-ing>
    <amt><qty>1</qty><unit>cup</unit></amt>
    <item>chocolate chips</item>
    <amt><qty>1</qty><unit>cup</unit></amt>
    <item>chopped walnuts</item>
  </alt-ing>
</ing>
```
- Multiple substitution options
- Mixed ingredient alternatives

#### 10. Equipment Lists
```xml
<equipment>
  <tool>Large mixing bowl</tool>
  <tool>Electric mixer</tool>
  <tool>Measuring cups and spoons</tool>
  <tool>Baking sheets</tool>
  <tool optional="yes">Cookie scoop</tool>
</equipment>
```
- Required and optional equipment
- Clear tool specifications

#### 11. Structured Directions
```xml
<step duration="2 minutes">
  Preheat oven to <temp><qty>375</qty><tempunit unit="F">°F</tempunit></temp>.
</step>
```
- Step timing information
- Temperature specifications with units
- Semantic markup for actions and conditions

#### 12. Nutrition Information
```xml
<nutrition standard="USDV">
  <nutrient-group>
    <title>Macronutrients (per cookie)</title>
    <nutrient>
      <n-name>Total Fat</n-name>
      <qty>7</qty>
      <unit>g</unit>
      <percent>11</percent>
    </nutrient>
  </nutrient-group>
</nutrition>
```
- Grouped nutritional data
- Percentages based on daily values
- Multiple nutrient formats

#### 13. Diet Exchange Information
```xml
<diet-exchanges authority="American Diabetes Association">
  <exchange><qty>1</qty> Carbohydrate</exchange>
  <exchange><qty>1<frac><n>1</n><d>2</d></frac></qty> Fat</exchange>
</diet-exchanges>
```
- Standardized diet exchange system
- Authority attribution
- Fractional exchanges

## Complex Recipe Example

**File**: `examples/complex-recipe.xml`  
**Recipe**: Beef Wellington with Red Wine Reduction

### Purpose
This example showcases advanced RecipeML features for complex, multi-component recipes. It demonstrates professional-level recipe documentation with detailed organization and cross-references.

### Key Features Demonstrated

#### 1. Metric System Specification
```xml
<recipe system="metric">
```
- Recipe-level measurement system declaration
- Consistent unit usage throughout

#### 2. Comprehensive Timing
```xml
<preptime type="preparation">
  <time><qty>45</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="chilling">
  <time><qty>2</qty><timeunit>hours</timeunit></time>
</preptime>
<preptime type="cooking">
  <time><qty>35</qty><timeunit>minutes</timeunit></time>
</preptime>
<preptime type="resting">
  <time><qty>15</qty><timeunit>minutes</timeunit></time>
</preptime>
```
- Multiple distinct timing phases
- Total recipe timeline planning

#### 3. Equipment Divisions
```xml
<equipment>
  <equip-div type="main">
    <title>Essential Equipment</title>
    <description>Basic equipment needed for the main preparation</description>
    <tool>Large heavy-bottomed skillet</tool>
    <tool>Food processor</tool>
  </equip-div>
  
  <equip-div type="optional">
    <title>Optional Equipment</title>
    <tool optional="yes">Kitchen twine</tool>
    <tool optional="yes">Pastry brush</tool>
  </equip-div>
</equipment>
```
- Organized equipment sections
- Descriptions and categorization
- Clear optional vs. required distinctions

#### 4. Ingredient Divisions
```xml
<ingredients>
  <ing-div type="main">
    <title>Beef Wellington</title>
    <description>Main components for the wellington</description>
    <!-- ingredients here -->
  </ing-div>
  
  <ing-div type="sauce">
    <title>Red Wine Reduction</title>
    <!-- sauce ingredients here -->
  </ing-div>
  
  <ing-div type="seasoning">
    <title>Seasonings</title>
    <!-- seasonings here -->
  </ing-div>
</ingredients>
```
- Logical ingredient grouping
- Multi-component recipe organization
- Clear component separation

#### 5. Ingredient References
```xml
<ing id="beef-tenderloin">
  <amt><qty>1.2</qty><unit>kg</unit></amt>
  <item>beef tenderloin</item>
  <prep>center cut, trimmed</prep>
  <ing-note>Ask butcher to trim and tie if needed</ing-note>
</ing>
```
- ID attributes for cross-referencing
- Detailed ingredient notes
- Professional preparation instructions

#### 6. Direction Divisions
```xml
<directions>
  <dir-div type="preparation" duration="30 minutes">
    <title>Preparation</title>
    <description>Initial preparation of all components</description>
    <!-- steps here -->
  </dir-div>
  
  <dir-div type="assembly" duration="15 minutes">
    <title>Wellington Assembly</title>
    <!-- assembly steps here -->
  </dir-div>
  
  <dir-div type="cooking" duration="45 minutes">
    <title>Cooking and Sauce</title>
    <!-- cooking steps here -->
  </dir-div>
</directions>
```
- Logical workflow organization
- Time estimates per section
- Clear phase descriptions

#### 7. Ingredient and Tool References
```xml
<step>
  Season the <ingref ingid="beef-tenderloin">beef tenderloin</ingref> generously 
  with salt and pepper on all sides.
</step>

<step>
  Heat olive oil in a <toolref toolid="heavy-skillet">large heavy-bottomed skillet</toolref> 
  over <setting value="high">high heat</setting>.
</step>
```
- Cross-references to ingredients and tools
- Semantic markup for equipment settings
- Dynamic linking within recipe

#### 8. Sub-steps
```xml
<step duration="8 minutes">
  Heat olive oil in a large heavy-bottomed skillet over high heat. 
  <action>Sear</action> the beef on all sides until <condition>golden brown</condition>, 
  about 2 minutes per side.
  <substep>
    The beef should be beautifully caramelized but still raw inside.
  </substep>
</step>
```
- Detailed step breakdown
- Additional clarifications
- Professional cooking guidance

#### 9. Parallel Cooking Instructions
```xml
<step duration="15 minutes" type="simultaneous">
  While wellington bakes, prepare red wine reduction: <action>Reduce</action> wine and stock 
  in saucepan over <setting>medium-high heat</setting> until <condition>syrupy</condition>, 
  about 15 minutes.
</step>
```
- Concurrent cooking processes
- Efficient time management
- Multi-tasking instructions

#### 10. Professional Cooking Elements
```xml
<step>
  <action>Sear</action> the beef on all sides until <condition>golden brown</condition>
</step>

<step>
  <action>Reduce</action> wine and stock until <condition>syrupy</condition>
</step>

<step>
  <action>Rest</action> wellington for 10-15 minutes before slicing
</step>
```
- Culinary action vocabulary
- Doneness conditions
- Professional techniques

#### 11. Comprehensive Notes
```xml
<note type="Warning">
  This recipe contains raw eggs in the egg wash and may not be suitable for pregnant women, 
  elderly, or immunocompromised individuals.
</note>

<note type="Make-Ahead">
  The wellington can be assembled up to 24 hours ahead and refrigerated before baking.
</note>

<note type="Wine Pairing">
  Serve with a full-bodied red wine such as Cabernet Sauvignon or Bordeaux.
</note>
```
- Safety warnings
- Make-ahead instructions
- Serving suggestions
- Professional presentation tips

## Menu Example

**File**: `examples/menu-example.xml`  
**Recipe**: Spring Dinner Party Menu

### Purpose
This example demonstrates how to create menu documents that contain multiple recipes organized by course, perfect for meal planning and entertaining.

### Key Features Demonstrated

#### 1. Menu Document Structure
```xml
<menu>
  <head>
    <title>Spring Dinner Party Menu</title>
    <subtitle>A Fresh Take on Seasonal Ingredients</subtitle>
    <categories>
      <cat type="season">spring</cat>
      <cat type="occasion">dinner party</cat>
      <cat type="style">contemporary</cat>
    </categories>
  </head>
```
- Menu-level organization
- Seasonal and occasion-based categorization
- Overall menu theming

#### 2. Menu Description
```xml
<description>
  This elegant spring menu celebrates the season's first fresh ingredients with 
  light, vibrant flavors perfect for entertaining. Each course builds upon the last, 
  creating a memorable dining experience that showcases the best of spring produce.
</description>
```
- Menu concept explanation
- Dining experience description
- Seasonal ingredient focus

#### 3. Course Organization
```xml
<recipe>
  <head>
    <title>Asparagus and Pea Soup with Mint Oil</title>
    <subtitle>First Course</subtitle>
    <categories>
      <cat type="course">appetizer</cat>
      <cat type="ingredient">asparagus</cat>
      <cat type="dietary">vegetarian</cat>
    </categories>
  </head>
```
- Course designation in subtitles
- Dietary restriction labeling
- Ingredient highlighting

#### 4. Streamlined Recipe Format
```xml
<directions>
  <step>
    <action>Simmer</action> asparagus and peas in stock for 15 minutes until tender.
  </step>
  <step>
    <action>Blend</action> until smooth, then <action>stir in</action> cream.
  </step>
</directions>
```
- Concise instructions for menu context
- Essential steps only
- Clear action sequences

#### 5. Menu-Level Notes
```xml
<note type="Planning">
  The soup and galette pastry can be made a day ahead. Start the galette 2 hours before serving.
</note>

<note type="Wine Pairing">
  Pair the first course with a crisp Sauvignon Blanc, the salmon with Chardonnay, 
  and finish with a light dessert wine or Prosecco.
</note>

<note type="Dietary">
  The soup and galette are vegetarian. The salmon can be substituted with portobello mushrooms 
  for a vegetarian main course.
</note>
```
- Menu timing coordination
- Wine pairing suggestions
- Dietary accommodation options
- Make-ahead planning

#### 6. Multi-Course Coordination
- First course: Light, seasonal soup
- Main course: Protein with vegetables
- Dessert: Seasonal fruit preparation
- Coordinated timing and preparation notes

## Common Patterns Across Examples

### 1. Structured Measurements
All examples demonstrate consistent measurement patterns:
- Quantities with fractions
- Ranges for flexibility  
- Temperature specifications
- Time elements with proper units

### 2. Semantic Markup
Consistent use of semantic elements:
- `<action>` for cooking verbs
- `<condition>` for doneness tests
- `<setting>` for equipment controls
- `<prep>` for ingredient preparation

### 3. Accessibility Features
- Clear section headers
- Descriptive element content
- Logical document structure
- Progressive enhancement with optional elements

### 4. Professional Presentation
- Proper attribution and sources
- Version control and dating
- Comprehensive metadata
- Multiple note types for different purposes

## Using These Examples

### For Learning
1. **Start with simple-recipe.xml** to understand basic structure
2. **Progress to complex-recipe.xml** for advanced features
3. **Study menu-example.xml** for multi-recipe organization

### For Templates
1. **Copy the structure** and replace content with your recipes
2. **Maintain the XML declaration and DOCTYPE** for validation
3. **Adapt the complexity level** to match your recipe needs

### For Testing
1. **Validate against the DTD** to ensure compliance
2. **Test rendering** with the provided XSL stylesheet
3. **Verify cross-references** work correctly in complex recipes

### For Extension
1. **Add your own categories** and metadata
2. **Create custom note types** for specific needs
3. **Develop ingredient and equipment libraries** with consistent IDs

## Best Practices from Examples

1. **Use consistent measurement systems** within a recipe
2. **Provide alternative ingredients** where appropriate
3. **Include timing information** for planning
4. **Add equipment lists** for complex recipes
5. **Structure complex recipes** with divisions
6. **Use cross-references** to link related elements
7. **Include comprehensive metadata** for cataloging
8. **Provide multiple note types** for different information
9. **Consider dietary restrictions** and alternatives
10. **Plan for make-ahead preparation** when possible

These examples provide a comprehensive foundation for creating your own RecipeML documents, from simple home recipes to professional cookbook content.
