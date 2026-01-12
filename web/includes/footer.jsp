<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-section brand-info">
            <div class="footer-logo">
                <i class="fa-solid fa-paw"></i>
                <span>PawPawMall</span>
            </div>
            <p>Your premier destination for high-quality cat food and toys. We care for your cats as much as you do.</p>
            <div class="social-links">
                <a href="#" class="social-icon"><i class="fa-brands fa-facebook"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
        </div>

        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="<%= ctx %>/index">Home</a></li>
                <li><a href="<%= ctx %>/ShopServlet">Shop All</a></li>
                <li><a href="<%= ctx %>/index#about-us">About Us</a></li>
                <li><a href="<%= ctx %>/CartServlet">My Cart</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3>Contact Us</h3>
            <ul class="contact-list">
                <li><i class="fa-solid fa-location-dot"></i>  PawPawMall, Penang, Malaysia</li>
                <li><i class="fa-solid fa-phone"></i> +60 123-456789</li>
                <li><i class="fa-solid fa-envelope"></i> CustomerSupport@pawpawmall.com</li>
            </ul>
        </div>

        <div class="footer-section newsletter">
            <h3>Join Our Newsletter</h3>
            <p>Subscribe to get special offers and pet care tips.</p>

            <form class="subscribe-form" id="newsletter-form">
                <input type="email" id="subscriber-email" placeholder="Enter your email" required>
                <button type="submit">Subscribe</button>
            </form>

            <div id="subscribe-success" style="display:none; color: #10b981; margin-top: 10px; font-weight: bold;">
                <i class="fa-solid fa-circle-check"></i> We've received your email!
            </div>
        </div>
    </div> <div class="footer-bottom">
    <p>&copy; 2025 PawPawMall. Developed by USM CAT201 Team. All Rights Reserved.</p>
</div>

    <script>
        document.getElementById('newsletter-form').addEventListener('submit', function(e) {
            e.preventDefault();
            const emailInput = document.getElementById('subscriber-email');
            const successMsg = document.getElementById('subscribe-success');

            if (emailInput.value) {
                this.style.display = 'none';
                successMsg.style.display = 'block';

                setTimeout(() => {
                    this.reset();
                    this.style.display = 'flex';
                    successMsg.style.display = 'none';
                }, 3000);
            }
        });
    </script>
</footer>
