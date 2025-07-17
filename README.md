# RecipeML Implementation

A comprehensive implementation of the RecipeML 0.5 specification featuring complete DTD validation, responsive Bootstrap 5 XSL stylesheet, and a static testing website. Transform XML recipe documents into beautiful, mobile-friendly web pages with support for fractions, measurements, equipment lists, nutrition data, and complex recipe structures. Perfect for developers working with recipe data or anyone wanting to create structured, semantic recipe documents.

## Overview

RecipeML (Recipe Markup Language) is an XML-based format for marking up recipes, originally created by FormatData in 2000. This project provides:

- **Complete DTD**: Full RecipeML 0.5 specification compliance
- **Modern XSL Stylesheet**: Bootstrap-based responsive rendering
- **Example Recipes**: Comprehensive test cases demonstrating all features
- **Static Website**: Easy browser-based testing interface

## Features

### DTD Implementation
- ✅ Complete RecipeML 0.5 specification
- ✅ All elements and attributes defined
- ✅ Proper entity definitions and content models
- ✅ Dublin Core metadata support

### XSL Stylesheet
- ✅ Responsive Bootstrap 5 design
- ✅ Modern iconography (Lucide icons)
- ✅ Support for all RecipeML elements:
  - Fractions with proper visual formatting
  - Measurement ranges and conversions
  - Equipment lists and references
  - Ingredient alternatives and modifiers
  - Step-by-step directions with timing
  - Nutrition information tables
  - Diet exchange information
  - Multiple note types and warnings
- ✅ Both recipe and menu document support

### Example Documents
- **Simple Recipe**: Chocolate chip cookies with basic features
- **Complex Recipe**: Beef Wellington with advanced structures
- **Menu Document**: Multi-course dinner party menu

## Quick Start

### Option 1: Static Website (Recommended)
1. Clone this repository
2. Open `index.html` in a modern web browser
3. Select an example recipe to view the rendered output
4. Upload your own RecipeML files to test

### Option 2: Direct XML Viewing
1. Open any `.xml` file from the `examples/` directory
2. Your browser should automatically apply the XSL transformation
3. View the rendered recipe in Bootstrap styling

## File Structure

```
recipeml-implementation/
├── README.md
├── LICENSE
├── index.html              # Static website interface
├── dtd/
│   └── recipeml.dtd        # Complete RecipeML 0.5 DTD
├── xsl/
│   └── recipe.xsl          # Bootstrap-based stylesheet
├── examples/
│   ├── simple-recipe.xml   # Chocolate chip cookies
│   ├── complex-recipe.xml  # Beef Wellington
│   └── menu-example.xml    # Spring dinner party menu
├── assets/
│   ├── css/
│   │   └── custom.css      # Additional styling
│   └── js/
│       └── app.js          # Static website functionality
└── docs/
    ├── specification.md    # RecipeML specification notes
    ├── getting-started.md  # Tutorial
    └── examples.md         # Example explanations
```

## Usage Examples

### Basic Recipe Structure
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE recipeml PUBLIC "-//FormatData//DTD RecipeML 0.5//EN" "dtd/recipeml.dtd">
<recipeml version="0.5" xml:lang="en">
  <recipe>
    <head>
      <title>My Recipe</title>
      <yield><qty>4</qty> <unit>servings</unit></yield>
    </head>
    <ingredients>
      <ing>
        <amt><qty>2</qty> <unit>cups</unit></amt>
        <item>flour</item>
      </ing>
    </ingredients>
    <directions>
      <step>Mix ingredients together.</step>
    </directions>
  </recipe>
</recipeml>
```

### Advanced Features
- **Fractions**: `<qty>2<frac><n>1</n><d>4</d></frac></qty>`
- **Ranges**: `<range><q1>3</q1><sep>to</sep><q2>4</q2></range>`
- **Alternatives**: `<alt-ing>` for ingredient substitutions
- **Equipment**: `<tool optional="yes">Stand mixer</tool>`
- **Timing**: `<step duration="5 minutes">Bake until golden</step>`

## Browser Compatibility

The XSL transformation works in all modern browsers:
- ✅ Chrome/Chromium
- ✅ Firefox
- ✅ Safari
- ✅ Edge

**Note**: Some browsers may require serving files via HTTP/HTTPS rather than opening directly due to CORS restrictions on local file access.

## RecipeML Specification

This implementation follows the RecipeML 0.5 specification originally published by FormatData. Key features include:

- **Structured Ingredients**: Precise amounts, units, preparations, and alternatives
- **Detailed Directions**: Steps, substeps, timing, and cross-references
- **Equipment Lists**: Required and optional tools
- **Nutrition Data**: Complete nutritional information with percentages
- **Metadata Support**: Dublin Core elements for cataloging
- **Internationalization**: Multi-language support via xml:lang

## Development

### Testing New Recipes
1. Create your RecipeML document following the examples
2. Validate against the DTD (most XML editors support this)
3. Open in browser or use the static website to view results

### Customizing Styles
The XSL stylesheet uses Bootstrap 5 classes. To customize:
1. Modify `xsl/recipe.xsl` for structural changes
2. Add custom CSS to `assets/css/custom.css`
3. Update JavaScript in `assets/js/app.js` for interactivity

### Contributing
1. Fork the repository
2. Create a feature branch
3. Test with the provided examples
4. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

The RecipeML specification is subject to the RecipeML Public License. See the original specification at FormatData for details.

## Acknowledgments

- **FormatData**: Original creators of the RecipeML specification
- **Bootstrap Team**: CSS framework
- **Lucide**: Icon library
- **RecipeML Community**: Continued support and usage

## Related Projects

- [Original RecipeML](http://www.formatdata.com/recipeml/) - FormatData's original specification
- [Largo Recipes](https://sourceforge.net/projects/largorecipes/) - Software supporting RecipeML
- [Recipe Markup Formats](https://microformats.org/wiki/recipe-formats) - Comparison of recipe formats

---

*For questions, issues, or contributions, please use the GitHub issue tracker.*
