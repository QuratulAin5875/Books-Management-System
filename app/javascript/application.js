import "@hotwired/turbo-rails";

function initSettingsMenu() {
  const settingsButton = document.getElementById('settings-btn');
  const settingsMenu = document.getElementById('settings-menu');
  const lightModeBtn = document.getElementById('light-mode-btn');
  const darkModeBtn = document.getElementById('dark-mode-btn');
  const fontIncreaseBtn = document.getElementById('font-increase');
  const fontDecreaseBtn = document.getElementById('font-decrease');

  if (!settingsButton || !settingsMenu) {
    console.warn('Settings elements missing:', { settingsButton, settingsMenu });
    return;
  }

  // Prevent duplicate listeners
  if (settingsButton.dataset.listenerAttached === "true") return;
  settingsButton.dataset.listenerAttached = "true";

  // Apply saved theme
  const savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'dark') document.body.classList.add('dark-mode');
  if (savedTheme === 'light') document.body.classList.remove('dark-mode');

  // Apply saved font size
  const savedFontPercent = parseInt(localStorage.getItem('chapterFontPercent'), 10);
  if (!isNaN(savedFontPercent)) {
    const chapterBody = document.querySelector('.book-chapter-body');
    if (chapterBody) {
      chapterBody.style.fontSize = savedFontPercent + '%';
    }
  }

  // Toggle settings menu
  settingsButton.addEventListener('click', (e) => {
    console.log("In setting event listner");
    e.stopPropagation();
    debugger;
    const expanded = settingsButton.getAttribute('aria-expanded') === 'true';
    settingsButton.setAttribute('aria-expanded', (!expanded).toString());
    settingsMenu.classList.toggle('hidden');
  });

  // Close menu on outside click
  document.addEventListener('click', (e) => {
    if (!settingsMenu.classList.contains('hidden') && !settingsMenu.contains(e.target) && !settingsButton.contains(e.target)) {
      settingsMenu.classList.add('hidden');
      settingsButton.setAttribute('aria-expanded', 'false');
    }
  });

  // Theme buttons
  if (lightModeBtn) {
    lightModeBtn.addEventListener('click', () => {
      document.body.classList.remove('dark-mode');
      localStorage.setItem('theme', 'light');
      console.log('Light mode activated');
    });
  }
  
  if (darkModeBtn) {
    darkModeBtn.addEventListener('click', () => {
      document.body.classList.add('dark-mode');
      localStorage.setItem('theme', 'dark');
      console.log('Dark mode activated');
    });
  }

  // Font size adjustment
  function clamp(v, min, max) {
    return Math.min(Math.max(v, min), max);
  }
  
  function getCurrentFontPercent() {
    const chapterBody = document.querySelector('.book-chapter-body');
    if (!chapterBody) return 100;
    
    const computed = window.getComputedStyle(chapterBody).fontSize;
    const base = 16;
    const currentPx = parseFloat(computed) || base;
    return Math.round((currentPx / base) * 100);
  }
  
  function setFontPercent(percent) {
    const clamped = clamp(percent, 85, 200);
    const chapterBody = document.querySelector('.book-chapter-body');
    if (chapterBody) {
      chapterBody.style.fontSize = clamped + '%';
      localStorage.setItem('chapterFontPercent', String(clamped));
      console.log('Font size set to:', clamped + '%');
    }
  }

  if (fontIncreaseBtn) {
    fontIncreaseBtn.addEventListener('click', () => {
      setFontPercent(getCurrentFontPercent() + 10);
    });
  }
  
  if (fontDecreaseBtn) {
    fontDecreaseBtn.addEventListener('click', () => {
      setFontPercent(getCurrentFontPercent() - 10);
    });
  }
}

// Initialize on various events
document.addEventListener('DOMContentLoaded', initSettingsMenu);
document.addEventListener('turbo:load', initSettingsMenu);
document.addEventListener('turbo:render', initSettingsMenu);