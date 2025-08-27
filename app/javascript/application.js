// application.js
import "@hotwired/turbo-rails"
import "@rails/ujs"

console.log("✅ application.js loaded");

document.addEventListener("turbo:load", () => {
  try {
    // Load saved theme from localStorage
    const savedTheme = localStorage.getItem("theme");
    if (savedTheme === "dark") {
      document.body.classList.add("dark-mode");
      console.log("Applied saved dark mode");
    } else {
      document.body.classList.remove("dark-mode");
      console.log("Applied saved light mode or default");
    }

    const settingsBtn = document.getElementById("settings-btn");
    const settingsMenu = document.getElementById("settings-menu");
    const lightModeBtn = document.getElementById("light-mode-btn");
    const darkModeBtn = document.getElementById("dark-mode-btn");
    const fontIncrease = document.getElementById("font-increase");
    const fontDecrease = document.getElementById("font-decrease");

    if (!settingsBtn || !settingsMenu) {
      console.error("Settings button or menu not found in DOM");
      return;
    }

    console.log("Settings button and menu found, attaching listeners");

    settingsBtn.addEventListener("click", () => {
      console.log("Settings button clicked");
      settingsMenu.classList.toggle("hidden");
    });

    if (lightModeBtn) {
      lightModeBtn.addEventListener("click", () => {
        console.log("Light mode button clicked");
        document.body.classList.remove("dark-mode");
        localStorage.setItem("theme", "light");
        settingsMenu.classList.add("hidden");
      });
    }

    if (darkModeBtn) {
      darkModeBtn.addEventListener("click", () => {
        console.log("Dark mode button clicked");
        document.body.classList.add("dark-mode");
        localStorage.setItem("theme", "dark");
        settingsMenu.classList.add("hidden");
      });
    }

    if (fontIncrease) {
      fontIncrease.addEventListener("click", () => {
        document.querySelectorAll(".book-chapter-body").forEach((el) => {
        const currentSize = parseFloat(getComputedStyle(el).fontSize);
        if (currentSize < 24) {
            console.log("Increasing font size");
            const newSize = currentSize + 2;
            el.style.fontSize = newSize + "px";
            localStorage.setItem("fontSize", newSize + "px");
        }
        });
      });
    }

    if (fontDecrease) {
      fontDecrease.addEventListener("click", () => {
        document.querySelectorAll(".book-chapter-body").forEach((el) => {
        const currentSize = parseFloat(getComputedStyle(el).fontSize);
        if (currentSize > 12) {
            console.log("Decreasing font size");
            const newSize = currentSize - 2;
            el.style.fontSize = newSize + "px";
            localStorage.setItem("fontSize", newSize + "px");
        }
        });
      });
    }

    // Restore saved font size
    const savedFontSize = localStorage.getItem("fontSize");
    if (savedFontSize) {
      document.querySelectorAll(".book-chapter-body").forEach((el) => {
        el.style.fontSize = savedFontSize;
      });
      console.log("Applied saved font size:", savedFontSize);
    }

    document.addEventListener("click", (event) => {
      if (!settingsBtn.contains(event.target) && !settingsMenu.contains(event.target)) {
        console.log("Clicked outside, closing menu");
        settingsMenu.classList.add("hidden");
      }
    });
  } catch (error) {
    console.error("Error in application.js:", error);
  }
});

if (typeof Rails !== "undefined") {
  Rails.start();
} else {
  console.warn("Rails UJS not defined, skipping Rails.start()");
}