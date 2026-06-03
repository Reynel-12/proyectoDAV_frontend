(function () {
    function initAppShell() {
        var menuBtn = document.getElementById('menuBtn');
        var sidebar = document.getElementById('sidebar');
        var overlay = document.getElementById('sidebarOverlay');

        if (!menuBtn || !sidebar || !overlay) {
            return;
        }

        function isCompactLayout() {
            return window.getComputedStyle(menuBtn).display !== 'none';
        }

        function setOpenState(isOpen) {
            var shouldOpen = isOpen && isCompactLayout();
            sidebar.classList.toggle('open', shouldOpen);
            overlay.classList.toggle('active', shouldOpen);
            overlay.setAttribute('aria-hidden', shouldOpen ? 'false' : 'true');
            menuBtn.setAttribute('aria-expanded', shouldOpen ? 'true' : 'false');
            document.body.classList.toggle('app-shell-open', shouldOpen);
        }

        function openSidebar() {
            setOpenState(true);
        }

        function closeSidebar() {
            setOpenState(false);
        }

        menuBtn.addEventListener('click', function () {
            if (!isCompactLayout()) {
                return;
            }
            setOpenState(!sidebar.classList.contains('open'));
        });

        overlay.addEventListener('click', closeSidebar);

        sidebar.addEventListener('click', function (event) {
            if (isCompactLayout() && event.target.closest('a')) {
                closeSidebar();
            }
        });

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeSidebar();
            }
        });

        window.addEventListener('resize', function () {
            if (!isCompactLayout()) {
                closeSidebar();
            }
        });

        window.appShell = {
            openSidebar: openSidebar,
            closeSidebar: closeSidebar
        };
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAppShell);
    } else {
        initAppShell();
    }
})();
