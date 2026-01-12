<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Product" %>
<%
    List<Product> allProducts = (List<Product>) request.getAttribute("productList");
%>
<%@ include file="/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management - PawPawMall</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
    <style>
        .admin-page-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }

        /* modal style */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(3px); }
        .modal-content { background: white; margin: 5% auto; padding: 30px; border-radius: 20px; width: 550px; position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.2); }
        .close-btn { position: absolute; right: 25px; top: 20px; font-size: 28px; cursor: pointer; color: #64748b; }

        /* table style */
        .management-table { width: 100%; border-collapse: collapse; background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .management-table th { background: #f8fafc; padding: 18px 20px; text-align: left; color: #64748b; border-bottom: 2px solid #f1f5f9; }
        .management-table td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        .prod-img-small { width: 60px; height: 60px; object-fit: cover; border-radius: 10px; border: 1px solid #eee; }

        /* pic preview */
        .preview-box { width: 100%; height: 180px; border: 2px dashed #e2e8f0; border-radius: 12px; margin-top: 10px; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #f8fafc; }
        #imagePreview { max-width: 100%; max-height: 100%; display: none; }
        #previewPlaceholder { color: #94a3b8; font-size: 0.9rem; }
    </style>
</head>
<body class="admin-body">

<div class="admin-page-container">
    <div class="page-header">
        <h2><i class="fa-solid fa-boxes-stacked"></i> Inventory Management</h2>
        <button class="btn-filled" onclick="openModal('add')">
            <i class="fa-solid fa-plus"></i> Add New Product
        </button>
    </div>

    <table class="management-table">
        <thead>
        <tr>
            <th>Image</th>
            <th>Product Details</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (allProducts != null) {
            for (Product p : allProducts) { %>
        <tr>
            <td><img src="<%= ctx %>/<%= p.getImagePath() %>" class="prod-img-small"></td>
            <td>
                <div style="font-weight: 600;"><%= p.getName() %></div>
                <div style="font-size: 0.8rem; color: #94a3b8;"><%= p.getDescription() != null ? p.getDescription() : "" %></div>
            </td>
            <td><span class="category-tag"><%= p.getCategory() %></span></td>
            <td>$<%= String.format("%.2f", p.getPrice()) %></td>
            <td>
                    <span class="stock-badge <%= p.getStock() < 10 ? "stock-low" : "stock-normal" %>">
                        <%= p.getStock() %>
                    </span>
            </td>
            <td>
                <div class="action-group">
                    <button class="edit-btn" onclick="openModal('edit', {
                            id: '<%= p.getId() %>',
                            name: '<%= p.getName() %>',
                            desc: '<%= p.getDescription() != null ? p.getDescription() : "" %>',
                            category: '<%= p.getCategory() %>',
                            price: '<%= p.getPrice() %>',
                            stock: '<%= p.getStock() %>',
                            image: '<%= p.getImagePath() %>'
                            })"><i class="fa-solid fa-pen-to-square"></i></button>

                    <form action="<%= ctx %>/ProductManagementServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <button type="submit" class="del-btn" onclick="return confirm('Delete this product?')">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>

<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2 id="modalTitle" style="margin-bottom: 25px;">Add Product</h2>

        <form action="<%= ctx %>/ProductManagementServlet" method="post" enctype="multipart/form-data" class="auth-form">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="productId" id="prodId">
            <input type="hidden" name="existingImagePath" id="existingPath">

            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" id="prodName" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" id="prodDesc" rows="2" style="width:100%; border:1px solid #ddd; border-radius:8px; padding:10px;"></textarea>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="category" id="prodCategory">
                    <option value="New arrivals">New Arrivals</option>
                    <option value="Cat Food">Cat Food</option>
                    <option value="Cat Toys">Cat Toys</option>
                    <option value="On Sale">On Sale</option>
                </select>
            </div>

            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label>Price ($)</label>
                    <input type="number" name="price" id="prodPrice" step="0.01" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Stock</label>
                    <input type="number" name="stock" id="prodStock" required>
                </div>
            </div>

            <div class="form-group">
                <label>Image Upload</label>
                <input type="file" name="image" id="imageInput" accept="image/*" onchange="handleImagePreview()">
                <div class="preview-box" style="margin-top: 10px; border: 1px dashed #ccc; min-height: 100px; display: flex; align-items: center; justify-content: center;">
                    <img src="" id="imagePreview" style="max-width: 100%; max-height: 150px; display: none;">
                    <span id="previewPlaceholder">Preview will appear here</span>
                </div>
            </div>

            <button type="submit" class="btn-filled" style="width: 100%; margin-top: 20px; padding: 12px;">Save Product</button>
        </form>
    </div>
</div>

<script>
    const modal = document.getElementById('productModal');
    const previewImg = document.getElementById('imagePreview');
    const placeholder = document.getElementById('previewPlaceholder');

    function openModal(mode, data = null) {
        modal.style.display = 'block';
        if (mode === 'edit' && data) {
            document.getElementById('modalTitle').innerText = 'Edit Product';
            document.getElementById('formAction').value = 'update';
            document.getElementById('prodId').value = data.id;
            document.getElementById('prodName').value = data.name;
            document.getElementById('prodDesc').value = data.desc;
            document.getElementById('prodCategory').value = data.category;
            document.getElementById('prodPrice').value = data.price;
            document.getElementById('prodStock').value = data.stock;
            document.getElementById('existingPath').value = data.image;

            previewImg.src = '<%= ctx %>/' + data.image;
            previewImg.style.display = 'block';
            placeholder.style.display = 'none';
        } else {
            document.getElementById('modalTitle').innerText = 'Add New Product';
            document.getElementById('formAction').value = 'add';
            document.getElementById('prodId').value = '';
            document.getElementById('existingPath').value = '';
            previewImg.style.display = 'none';
            placeholder.style.display = 'block';
            document.querySelector('.auth-form').reset();
        }
    }

    function closeModal() { modal.style.display = 'none'; }

    function handleImagePreview() {
        const file = document.getElementById('imageInput').files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                previewImg.style.display = 'block';
                placeholder.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    }

    window.onclick = function(event) { if (event.target == modal) closeModal(); }
</script>

<%@ include file="/includes/footer.jsp" %>
</body>
</html>