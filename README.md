# 🔥 Firefly (螢火蟲) Vector Database

[正體中文](#正體中文) | [English](#english)

---

## 正體中文

### 給開發者 (For Humans)

**Firefly** 是一個用純 Mojo 語言編寫的高效能向量相似度搜尋引擎。專為展示 Mojo 強大的硬體加速（SIMD）能力與底層記憶體控制所設計。本專案採零外部依賴，適合需要極致效能與嚴格安全性的開源社群。

#### 核心特色
- 🚀 **硬體加速最佳化**：原生支援 SIMD（單指令多資料流）與 FMA 指令引擎，距離計算（餘弦、歐幾里得、點積）無分支執行。
- 🔍 **強大的索引系統**：內建精確的暴力搜尋（Brute-force），以及即將到來的百萬級向量毫秒級搜尋演算法（HNSW）。
- 💾 **自訂二進位儲存**：針對記憶體映射（Memory-mapped）最佳化的專屬二進位格式，支援光速載入。
- 🤖 **為 AI 而生**：內建標準化 JSON I/O 的 CLI，隨時準備好作為 AI 代理（Agent）的擴充工具。

#### 快速開始

```bash
# 建置與測試
make test
make bench

# 透過 CLI 操作（回傳結果皆為 JSON）
mojo run main.mojo help
mojo run main.mojo create
```

---

## English

### For Developers (For Humans)

**Firefly** is a high-performance vector similarity search engine written in pure Mojo. It is designed to showcase the raw hardware acceleration (SIMD) capabilities and low-level memory control that Mojo offers. With zero external dependencies, this project is built for open-source ecosystems that demand bleeding-edge performance and strict security.

#### Key Features
- 🚀 **Hardware Accelerated**: Native SIMD and FMA (Fused Multiply-Add) support for branchless distance calculations (Cosine, Euclidean, Dot Product).
- 🔍 **Robust Indexing**: Includes exact Brute-force search and foundations for million-scale sub-millisecond search (HNSW).
- 💾 **Custom Binary Persistence**: Optimized binary format designed for extremely fast loading and memory mapping.
- 🤖 **AI-Native**: A CLI built completely around standard JSON I/O, ready to be immediately plugged in as an AI Agent tool.

#### Quick Start

```bash
# Build & Test
make test
make bench

# CLI Usage (All outputs are JSON)
mojo run main.mojo help
mojo run main.mojo create
```

---
---

## 🤖 給 AI 代理的系統指令 (For AI Agents)

> **[System Prompt / 系統提示]**
> You are currently interacting with the Firefly Vector Database. Firefly provides a CLI interface where all inputs and outputs are strict JSON formats. You can use it as an external Tool for Memory or RAG (Retrieval-Augmented Generation).
>
> 這是 Firefly 向量庫的代理呼叫說明。所有的 CLI 互動皆為 JSON 格式。請依照以下規範使用：

### Available Tools (CLI Commands) / 可用指令

#### 1. Create Index (建立索引)
- **Command:** `create`
- **Output:** `{"status": "success", "message": "Index created"}`

#### 2. Get Index Info (取得索引狀態)
- **Command:** `info`
- **Output:** `{"status": "success", "dimension": 128, "size": 0}`

#### 3. Search Vectors (搜尋向量) - *Work In Progress*
- **Description:** Given a query vector, returns the Top-K most similar vectors.
- **Input (stdin):** `{"vector": [0.12, 0.55, ...], "k": 10}`
- **Output:** `[{"id": 42, "distance": 0.05, "score": 0.95}, ...]`

#### 4. Insert Vector (寫入向量) - *Work In Progress*
- **Description:** Insert an embedding vector into the database.
- **Input (stdin):** `{"id": 1, "vector": [0.12, 0.55, ...]}`
- **Output:** `{"status": "success", "id": 1}`

### Agent Error Handling / 錯誤處理機制
If a command fails, you will receive a JSON output with the error field. You MUST parse this JSON to determine the next action.
若執行失敗，請務必解析回傳的 JSON 並採取相應措施：
- **Example Error:** `{"error": "Dimension mismatch: expected 128, but got 768", "code": "DIMENSION_MISMATCH"}`
