// Google Apps Script - 態沃果園訂單系統
// 
// ====== 設定步驟 ======
// 1. 開啟 Google Sheets (sheets.google.com) → 建立新的試算表
// 2. 將試算表命名為「態沃果園訂單」
// 3. 在第一列 (Row 1) 加入以下欄位標題：
//    A1: 下單時間 | B1: 姓名 | C1: 電話 | D1: 地址 | E1: 商品 | F1: 數量 | G1: 付款方式 | H1: 備註 | I1: 狀態
// 4. 點選「擴充功能」→「Apps Script」
// 5. 刪除預設程式碼，貼上以下程式碼
// 6. 點選「部署」→「新增部署作業」
//    - 類型選「網頁應用程式」
//    - 執行身分選「我」
//    - 誰可以存取選「所有人」
//    - 點選「部署」
// 7. 複製部署出來的網址 (URL)
// 8. 貼到 iOS App 的 OrderNotificationService.swift 的 googleScriptURL 裡
// ========================

// Handle POST requests
function doPost(e) {
    try {
        var data = JSON.parse(e.postData.contents);
        return writeOrder(data);
    } catch (error) {
        return ContentService
            .createTextOutput(JSON.stringify({ status: 'error', message: error.toString() }))
            .setMimeType(ContentService.MimeType.JSON);
    }
}

// Handle GET requests (used as fallback when POST is redirected)
function doGet(e) {
    try {
        var data = {
            name: e.parameter.name || '',
            phone: e.parameter.phone || '',
            address: e.parameter.address || '',
            product: e.parameter.product || '',
            quantity: e.parameter.quantity || '',
            paymentMethod: e.parameter.paymentMethod || '',
            notes: e.parameter.notes || ''
        };

        // Only write if there's actual data
        if (data.name || data.phone) {
            return writeOrder(data);
        }

        return ContentService
            .createTextOutput(JSON.stringify({ status: 'ok', message: '態沃果園訂單系統已啟動' }))
            .setMimeType(ContentService.MimeType.JSON);
    } catch (error) {
        return ContentService
            .createTextOutput(JSON.stringify({ status: 'error', message: error.toString() }))
            .setMimeType(ContentService.MimeType.JSON);
    }
}

// Write order data to the spreadsheet
function writeOrder(data) {
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();

    sheet.appendRow([
        new Date().toLocaleString('zh-TW', { timeZone: 'Asia/Taipei' }),
        data.name || '',
        data.phone || '',
        data.address || '',
        data.product || '',
        data.quantity || '',
        data.paymentMethod || '',
        data.notes || '',
        '未處理'
    ]);

    return ContentService
        .createTextOutput(JSON.stringify({ status: 'success' }))
        .setMimeType(ContentService.MimeType.JSON);
}

// Test function
function testDoPost() {
    var testData = {
        postData: {
            contents: JSON.stringify({
                name: '測試用戶',
                phone: '0912-345-678',
                address: '台北市中正區測試路1號',
                product: '日本種香丁 (10斤 - 390元)',
                quantity: '2',
                paymentMethod: 'Apple Pay',
                notes: '測試訂單'
            })
        }
    };

    var result = doPost(testData);
    Logger.log(result.getContent());
}
