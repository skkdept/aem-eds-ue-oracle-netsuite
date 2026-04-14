/**
 * EDS Block Template - JavaScript
 * 
 * This is a template for creating EDS block components.
 * Copy this file and customize for your block.
 */

/**
 * Decorates the block and initializes its functionality
 * 
 * @param {HTMLElement} block - The block element to decorate
 * 
 * @example
 * // The block HTML structure will be:
 * // <div class="block-name">
 * //   <div> <!-- metadata row -->
 * //     <div>Value 1</div>
 * //     <div>Value 2</div>
 * //   </div>
 * //   <div> <!-- content row -->
 * //     ...
 * //   </div>
 * // </div>
 */
export default function decorate(block) {
  // Get the block wrapper and all rows
  const rows = block.querySelectorAll('div > div');

  // Initialize block state
  const state = {
    initialized: false,
    items: [],
    activeIndex: -1,
  };

  /**
   * Process and structure block content
   */
  function processContent() {
    rows.forEach((row, index) => {
      // Add data attribute for targeting specific rows
      row.setAttribute('data-row-index', index);

      // Add accessibility role
      if (!row.hasAttribute('role')) {
        const role = index === 0 ? 'heading' : 'article';
        row.setAttribute('role', role);
      }

      // Store reference to items
      state.items.push(row);

      console.log(`Block processed row ${index}`);
    });

    state.initialized = true;
  }

  /**
   * Attach event listeners using event delegation
   * This is more performant than attaching to each item
   */
  function attachEventListeners() {
    // Click handler with event delegation
    block.addEventListener('click', (e) => {
      // Find the closest interactive element
      const button = e.target.closest('button, a, [role="button"]');
      if (button) {
        handleInteraction(button);
      }
    });

    // Keyboard navigation
    block.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        const button = e.target.closest('button, a, [role="button"]');
        if (button) {
          handleInteraction(button);
          e.preventDefault();
        }
      }

      // Arrow key navigation (if applicable)
      if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
        handleArrowNavigation(e);
      }
    });

    // Hover effects
    block.addEventListener('mouseover', (e) => {
      const item = e.target.closest('[role="article"], li');
      if (item) {
        item.classList.add('hovered');
      }
    });

    block.addEventListener('mouseout', (e) => {
      const item = e.target.closest('[role="article"], li');
      if (item) {
        item.classList.remove('hovered');
      }
    });
  }

  /**
   * Handle user interaction
   * @param {HTMLElement} element - Element that was interacted with
   */
  function handleInteraction(element) {
    const itemIndex = state.items.indexOf(element.closest('[data-row-index]'));
    
    if (itemIndex >= 0) {
      state.activeIndex = itemIndex;
      element.classList.add('active');
      
      // Emit custom event for parent tracking
      block.dispatchEvent(new CustomEvent('block-item-selected', {
        detail: { index: itemIndex, element },
      }));

      console.log(`Item ${itemIndex} selected`);
    }
  }

  /**
   * Handle arrow key navigation
   * @param {KeyboardEvent} event - Keyboard event
   */
  function handleArrowNavigation(event) {
    const direction = event.key === 'ArrowDown' ? 1 : -1;
    const nextIndex = state.activeIndex + direction;

    if (nextIndex >= 0 && nextIndex < state.items.length) {
      const nextItem = state.items[nextIndex];
      nextItem.focus();
      state.activeIndex = nextIndex;
      event.preventDefault();
    }
  }

  /**
   * Enable lazy loading for images
   */
  function enableImageLazyLoading() {
    const images = block.querySelectorAll('img');

    if ('IntersectionObserver' in window) {
      const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const img = entry.target;
            
            // Check if image uses data-src (lazy load marker)
            if (img.dataset.src) {
              img.src = img.dataset.src;
              img.removeAttribute('data-src');
            }

            // Ensure alt text for accessibility
            if (!img.hasAttribute('alt')) {
              img.setAttribute('alt', 'Image content');
            }

            imageObserver.unobserve(img);
          }
        });
      }, {
        rootMargin: '50px', // Start loading 50px before visible
      });

      images.forEach((img) => {
        imageObserver.observe(img);
      });
    } else {
      // Fallback for browsers without IntersectionObserver
      images.forEach((img) => {
        if (img.dataset.src) {
          img.src = img.dataset.src;
        }
      });
    }
  }

  /**
   * Ensure accessibility compliance
   */
  function ensureAccessibility() {
    // Check for headings
    if (!block.querySelector('h1, h2, h3')) {
      console.warn('Block should contain at least one heading for accessibility');
    }

    // Verify link text is descriptive
    block.querySelectorAll('a').forEach((link) => {
      const text = link.textContent.trim();
      if (!text || text.toLowerCase() === 'click here') {
        console.warn('Link text should be descriptive:', link);
      }
    });

    // Verify images have alt text
    block.querySelectorAll('img').forEach((img) => {
      if (!img.hasAttribute('alt')) {
        console.warn('Image missing alt text:', img.src);
      }
    });
  }

  /**
   * Public API for block manipulation
   */
  const api = {
    getItems: () => [...state.items],
    getActiveIndex: () => state.activeIndex,
    setActive: (index) => {
      if (index >= 0 && index < state.items.length) {
        state.activeIndex = index;
        state.items[index].classList.add('active');
      }
    },
    reload: () => {
      state.items = [];
      processContent();
    },
  };

  /**
   * Initialize block
   */
  function initialize() {
    try {
      processContent();
      attachEventListeners();
      enableImageLazyLoading();
      ensureAccessibility();

      // Expose API on block for external access
      block.blockAPI = api;

      console.log('Block initialized successfully');
    } catch (error) {
      console.error('Error initializing block:', error);
    }
  }

  // Start initialization
  initialize();
}
