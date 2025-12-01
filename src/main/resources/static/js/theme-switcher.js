/**
 * Theme Switcher for BookStore Client
 * Toggles between Light Mode (Midnight Purple) and Dark Mode (Midnight Blue)
 * Persists user preference in localStorage
 */

(function () {
    'use strict';

    const THEME_KEY = 'bookstore-theme';
    const THEME_LIGHT = 'light';
    const THEME_DARK = 'dark';

    /**
     * Get the current theme from localStorage or default to light
     */
    function getCurrentTheme() {
        return localStorage.getItem(THEME_KEY) || THEME_LIGHT;
    }

    /**
     * Set the theme on the document
     */
    function setTheme(theme) {
        if (theme === THEME_DARK) {
            document.documentElement.setAttribute('data-theme', 'dark');
        } else {
            document.documentElement.removeAttribute('data-theme');
        }
        localStorage.setItem(THEME_KEY, theme);
    }

    /**
     * Toggle between light and dark themes
     */
    function toggleTheme() {
        const currentTheme = getCurrentTheme();
        const newTheme = currentTheme === THEME_LIGHT ? THEME_DARK : THEME_LIGHT;
        setTheme(newTheme);
        updateThemeIcon();
    }

    /**
     * Update the theme toggle button icon
     */
    function updateThemeIcon() {
        const themeToggle = document.getElementById('theme-toggle');
        if (!themeToggle) return;

        const currentTheme = getCurrentTheme();
        const icon = themeToggle.querySelector('i');

        if (currentTheme === THEME_DARK) {
            // Show sun icon for switching to light mode
            icon.className = 'fas fa-sun';
            themeToggle.setAttribute('aria-label', 'Cambiar a modo claro');
            themeToggle.setAttribute('title', 'Modo Claro');
        } else {
            // Show moon icon for switching to dark mode
            icon.className = 'fas fa-moon';
            themeToggle.setAttribute('aria-label', 'Cambiar a modo oscuro');
            themeToggle.setAttribute('title', 'Modo Oscuro');
        }
    }

    /**
     * Initialize theme on page load
     */
    function initTheme() {
        // Apply saved theme immediately to prevent flash
        const savedTheme = getCurrentTheme();
        setTheme(savedTheme);

        // Update icon when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', updateThemeIcon);
        } else {
            updateThemeIcon();
        }

        // Add click listener to theme toggle button
        document.addEventListener('DOMContentLoaded', function () {
            const themeToggle = document.getElementById('theme-toggle');
            if (themeToggle) {
                themeToggle.addEventListener('click', toggleTheme);
            }
        });
    }

    // Initialize immediately
    initTheme();

    // Expose toggle function globally for inline onclick if needed
    window.toggleTheme = toggleTheme;

})();
