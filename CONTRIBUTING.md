# Contributing to PrestaShop Statistics Module

First off, thank you for considering contributing to the PrestaShop Statistics Module! It's people like you that make this module better for everyone.

## Code of Conduct

This project and everyone participating in it is governed by common sense and mutual respect. By participating, you are expected to uphold this standard.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and expected**
- **Include screenshots if applicable**
- **Include your environment details:**
  - PrestaShop version
  - PHP version
  - MySQL version
  - Browser and version
  - Module version

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the enhancement**
- **Explain why this enhancement would be useful**
- **Include mockups or examples if applicable**

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/giulianodemar-netizen/Prestashopstats.git
   cd Prestashopstats
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Make your changes**
   - Follow the coding standards (see below)
   - Add or update tests if applicable
   - Update documentation if needed

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: your feature description"
   ```
   
   Follow these commit message conventions:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation changes
   - `style:` for code style changes
   - `refactor:` for code refactoring
   - `test:` for test additions or changes
   - `chore:` for maintenance tasks

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Provide a clear description of your changes

## Coding Standards

### PHP

Follow [PSR-12](https://www.php-fig.org/psr/psr-12/) coding standards:

```php
<?php
/**
 * Class description
 */
class ExampleClass
{
    /**
     * Method description
     *
     * @param string $param Description
     * @return bool
     */
    public function exampleMethod($param)
    {
        // Code here
        return true;
    }
}
```

### SQL

- Always use prepared statements or PrestaShop's `pSQL()` function
- Never trust user input
- Use proper table prefixes with `_DB_PREFIX_`

```php
$sql = 'SELECT * FROM `'._DB_PREFIX_.'table` 
        WHERE field = "'.pSQL($value).'"';
```

### Smarty Templates

- Use proper escaping: `{$variable|escape:'html':'UTF-8'}`
- Keep logic minimal in templates
- Use translation functions: `{l s='Text' mod='prestashopstats'}`

### JavaScript

- Use ES5 for compatibility
- Wrap code in document ready
- Comment complex logic

```javascript
$(document).ready(function() {
    // Your code here
});
```

### CSS

- Use meaningful class names
- Follow BEM naming convention when appropriate
- Ensure responsive design
- Test on multiple browsers

```css
.prestashopstats-dashboard {
    /* Styles */
}

.prestashopstats-dashboard__element {
    /* Styles */
}
```

## Testing

### Manual Testing

Before submitting:

1. Test on clean PrestaShop installation
2. Test with existing data
3. Test with different date ranges
4. Test responsive design
5. Test in multiple browsers
6. Check for PHP errors
7. Check for JavaScript console errors

### Test Checklist

- [ ] Module installs without errors
- [ ] Module uninstalls cleanly
- [ ] Database tables created correctly
- [ ] All features work as expected
- [ ] No PHP warnings or errors
- [ ] No JavaScript errors
- [ ] Responsive design works
- [ ] Translations work correctly
- [ ] Configuration saves properly
- [ ] Performance is acceptable

## Documentation

When adding features:

1. Update README.md if needed
2. Update DOCUMENTATION.md with usage details
3. Update CHANGELOG.md following format
4. Add inline code comments for complex logic
5. Update INSTALLATION.md if installation changes

## Translation

To add a new language:

1. Copy `translations/en.php`
2. Rename to your language code (e.g., `fr.php`)
3. Translate all strings
4. Test the translations
5. Submit as PR

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Feel free to open an issue for:
- Questions about contributing
- Clarification on requirements
- Discussion about features

## Recognition

Contributors will be acknowledged in:
- CHANGELOG.md
- Repository contributors page
- Module about section (future feature)

## Thank You!

Your contributions make this project better for everyone. Thank you for taking the time to contribute!

---

**Happy Coding!** 🚀
