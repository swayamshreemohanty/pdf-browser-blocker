# 🛡️ PDF Browser Blocker

A lightweight, script-based utility to enforce security compliance by preventing web browsers from opening PDF files internally.

These batch scripts configure **Google Chrome**, **Microsoft Edge**, **Brave**, and **Mozilla Firefox** to force-download all PDF files. This ensures that users view documents in a designated, secure, or offline desktop PDF viewer (like Adobe Acrobat Reader) rather than potentially insecure browser engines.

## 🚀 Features
* **One-Click Lock:** Instantly disables the internal PDF viewer for major browsers.
* **One-Click Unlock:** Reverts settings to default behavior (browsers open PDFs).
* **Admin-Level Enforcement:** Uses Windows Registry (`HKLM`) and Group Policy mechanisms (`policies.json`) for system-wide application.
* **No Installation Required:** Pure Windows Batch scripts (`.bat`).

## 📂 Files Included
* `PDF_Browser_Block.bat`: The lockdown script.
* `PDF_Browser_Unblock.bat`: The restoration script.

## ⚙️ How It Works

### The Blocking Mechanism (`PDF_Browser_Block.bat`)
1.  **Chrome / Edge / Brave:** Sets the `AlwaysOpenPdfExternally` policy to `1` (True) in the Windows Registry (`HKLM\SOFTWARE\Policies\...`).
2.  **Firefox:** Generates a `policies.json` file in the Firefox installation directory to disable `PDFjs` (the internal viewer).
3.  **Applies Immediately:** Automatically restarts browser processes to ensure the new policies take effect.

### The Unblocking Mechanism (`PDF_Browser_Unblock.bat`)
1.  **Registry Cleanup:** Deletes the specific policy keys created by the block script.
2.  **File Cleanup:** Removes the `policies.json` file from the Firefox directory.
3.  **Applies Immediately:** Restarts browsers to restore default behavior.

## 📖 Usage Guide

### Prerequisites
* Windows 10 or Windows 11.
* **Administrator Privileges** (Required to edit Registry and Program Files).

### Steps
1.  Download the repository or the `.bat` files.
2.  **To Block:**
    * Right-click `PDF_Browser_Block.bat`.
    * Select **Run as Administrator**.
    * Wait for the "Success" messages and the browser restart.
3.  **To Unblock:**
    * Right-click `PDF_Browser_Unblock.bat`.
    * Select **Run as Administrator**.

## ⚠️ Important Notes
* **Browser Restart:** Both scripts will forcibly close Chrome, Edge, Brave, and Firefox to apply changes. **Save your work** in these browsers before running the scripts.
* **Enterprise Environments:** If your computer is managed by an organization (School/Work), these scripts might conflict with existing Group Policies.

## 📜 License
This project is open-source. Feel free to modify it for your specific IT environment.
