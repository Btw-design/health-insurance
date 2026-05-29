/* ============================================================
   Health Insurance Info - Main JavaScript
   ============================================================ */

document.addEventListener('DOMContentLoaded', function () {

  /* --- Nav Toggle --- */
  var toggle = document.querySelector('.nav-toggle');
  var navMenu = document.querySelector('.nav-menu');

  if (toggle && navMenu) {
    toggle.addEventListener('click', function () {
      navMenu.classList.toggle('open');
      var expanded = navMenu.classList.contains('open');
      toggle.setAttribute('aria-expanded', expanded);
    });

    // Close on outside click
    document.addEventListener('click', function (e) {
      if (!toggle.contains(e.target) && !navMenu.contains(e.target)) {
        navMenu.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  /* --- Header Scroll Effect --- */
  var header = document.querySelector('.site-header');
  if (header) {
    window.addEventListener('scroll', function () {
      if (window.scrollY > 10) {
        header.classList.add('scrolled');
      } else {
        header.classList.remove('scrolled');
      }
    });
  }

  /* --- FAQ Accordion --- */
  var faqQuestions = document.querySelectorAll('.faq-question');
  faqQuestions.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var item = btn.closest('.faq-item');
      if (!item) return;

      var isOpen = item.classList.contains('open');

      // Optional: close others
      // var parent = item.closest('.faq-list') || item.closest('.faq-category');
      // if (parent) {
      //   parent.querySelectorAll('.faq-item.open').forEach(function (other) {
      //     if (other !== item) other.classList.remove('open');
      //   });
      // }

      if (isOpen) {
        item.classList.remove('open');
      } else {
        item.classList.add('open');
      }
    });
  });

  /* --- Subscription Forms --- */
  var subForms = document.querySelectorAll('.sub-form');
  subForms.forEach(function (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var input = form.querySelector('input[type="email"]');
      var email = input ? input.value.trim() : '';

      if (email && email.indexOf('@') > -1 && email.indexOf('.') > -1) {
        // Success
        var parent = form.parentElement;
        form.style.display = 'none';
        var existingMsg = parent.querySelector('.form-success');
        if (existingMsg) {
          existingMsg.style.display = 'block';
        } else {
          var msg = document.createElement('p');
          msg.className = 'form-success';
          msg.textContent = 'Thank you for subscribing! We will keep you informed.';
          parent.appendChild(msg);
        }
        if (input) input.value = '';
      } else {
        if (input) {
          input.style.borderColor = '#D4A84B';
          input.focus();
          setTimeout(function () {
            input.style.borderColor = '';
          }, 2000);
        }
      }
    });
  });

  /* --- Smooth Scroll for Anchor Links --- */
  document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
    anchor.addEventListener('click', function (e) {
      var href = anchor.getAttribute('href');
      if (href === '#') return;
      var target = document.querySelector(href);
      if (target) {
        e.preventDefault();
        var headerOffset = 90;
        var targetPosition = target.getBoundingClientRect().top + window.pageYOffset - headerOffset;
        window.scrollTo({
          top: targetPosition,
          behavior: 'smooth'
        });
        // Update URL hash without jump
        history.pushState(null, '', href);
      }
    });
  });

  /* --- Current Year in Footer --- */
  var yearEl = document.getElementById('current-year');
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }

});
