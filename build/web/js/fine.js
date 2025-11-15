document.addEventListener("DOMContentLoaded", function () {
    const fineDetailBody = document.getElementById("fineDetailBody");
    const totalFineAmount = document.getElementById("totalFineAmount");
    const fineForm = document.getElementById("fineForm");

    // Dữ liệu đã chọn
    let selectedFines = JSON.parse(sessionStorage.getItem("selectedFines")) || [];

    // Hàm cập nhật checkbox event
    function attachCheckboxEvents() {
        const fineCheckboxes = document.querySelectorAll(".fine-checkbox");
        fineCheckboxes.forEach(checkbox => {
            checkbox.addEventListener("change", function () {
                const fineId = this.dataset.fineId;
                const fineName = this.dataset.fineName;
                const fineAmount = parseInt(this.dataset.fineAmount);
                const barcode = this.dataset.barcode;

                if (this.checked) {
                    // Chỉ thêm nếu chưa có
                    if (!selectedFines.some(f => f.fineId === fineId && f.barcode === barcode)) {
                        const fineItem = { fineId, fineName, fineAmount, barcode };
                        selectedFines.push(fineItem);
                        addFineDetailRow(fineItem);
                    }
                } else {
                    removeFineDetailRow(fineId, barcode);
                    selectedFines = selectedFines.filter(f => !(f.fineId === fineId && f.barcode === barcode));
                }

                sessionStorage.setItem("selectedFines", JSON.stringify(selectedFines));
                updateTotal();
            });
        });
    }

    // Thêm dòng chi tiết phạt
    function addFineDetailRow({ fineId, fineName, fineAmount, barcode }) {
        if (document.querySelector(`tr[data-fine-id="${fineId}"][data-barcode="${barcode}"]`)) return;

        // Xóa dòng "Select fines..." nếu có
        const emptyRow = fineDetailBody.querySelector("tr td[colspan]");
        if (emptyRow) fineDetailBody.innerHTML = "";

        const row = document.createElement("tr");
        row.dataset.fineId = fineId;
        row.dataset.barcode = barcode;
        row.innerHTML = `
            <td></td>
            <td>${fineId}</td>
            <td>${barcode}</td>
            <td>${fineName}</td>
            <td style="text-align:right;">${fineAmount.toLocaleString("vi-VN")} VNĐ</td>
            <td><input type="text" name="note_${fineId}_${barcode}" class="note-input" placeholder="Enter note..."></td>
        `;
        fineDetailBody.appendChild(row);

        updateRowNumbers();

        // Thêm hidden input vào form
        ["fineName", "fineAmount", "barcode"].forEach(type => {
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = `${type}_${fineId}_${barcode}`;
            input.value = type === "fineAmount" ? fineAmount : type === "fineName" ? fineName : barcode;
            fineForm.appendChild(input);
        });
    }

    // Xoá dòng chi tiết phạt
    function removeFineDetailRow(fineId, barcode) {
        const row = document.querySelector(`tr[data-fine-id="${fineId}"][data-barcode="${barcode}"]`);
        if (row) row.remove();

        // Xoá hidden input
        ["fineName", "fineAmount", "barcode"].forEach(type => {
            const hidden = fineForm.querySelector(`input[name="${type}_${fineId}_${barcode}"]`);
            if (hidden) hidden.remove();
        });

        if (fineDetailBody.children.length === 0) {
            fineDetailBody.innerHTML = `<tr><td colspan="6" style="text-align:center;">Select fines above to view details.</td></tr>`;
        }

        updateRowNumbers();
    }

    // Cập nhật số thứ tự
    function updateRowNumbers() {
        Array.from(fineDetailBody.querySelectorAll("tr[data-fine-id]")).forEach((tr, index) => {
            tr.children[0].textContent = index + 1;
        });
    }

    // Cập nhật tổng tiền
    function updateTotal() {
        const total = Array.from(fineDetailBody.querySelectorAll("tr[data-fine-id]"))
            .reduce((sum, row) => {
                const amount = row.children[4].textContent.replace(/[^\d]/g, "");
                return sum + parseInt(amount || 0);
            }, 0);
        totalFineAmount.textContent = total.toLocaleString("vi-VN") + " VNĐ";
    }

    // Khôi phục state từ sessionStorage
    function restoreState() {
        selectedFines.forEach(item => {
            const checkbox = document.querySelector(`.fine-checkbox[data-fine-id="${item.fineId}"][data-barcode="${item.barcode}"]`);
            if (checkbox) checkbox.checked = true;
            addFineDetailRow(item);
        });
        updateTotal();
    }

    restoreState();
    attachCheckboxEvents();
});
