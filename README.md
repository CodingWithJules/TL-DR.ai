# 📊 Narrative Analysis MVP
A lightweight system for extracting **overall summaries**, **dominant narratives**, and **representative comments** from large batches of Facebook comments using a **local Qwen2.5-7B model**.

This MVP includes:

- 🚀 Streamlit user interface  
- 🧠 Local LLM backend (Qwen2.5-7B-Instruct)  
- 🧹 A JSON restructuring tool for normalization  
- 📦 Modular backend analysis engine  
- 📁 Support for JSON uploads or manual text input  

# How to run 🚀

- Pull analysis.py restructure.py ui.py
- Run restructure-emoji.py --> prompts for JSON selection --> select raw JSON file from desktop --> saves structured JSON on desktop
- Run [streamlit run ui.py] --> opens streamlit ui --> upload structured JSON file --> click Run Narrative Analysis (takes a few minutes)
- View results --> results are downloadable / saved in root directory data/sm_comments

---

# 📥 1. Data Collection

This system expects Facebook comments in JSON format.  
Each comment entry must include a `"text"` field.

Example raw item:

```json
{
  "id": "1913950356145953","typename": "SM_COMMENT","text": "I like turtles" .. ... ..... .......
}
```

---

# 📁 2. Repository Structure

Your project should follow this layout:

```
project_root/
│
├── ui.py                         # Streamlit interface
│
├── core/
│   ├── analysis.py               # Main narrative analysis logic
│
├── restructure-emoji.py          # Data normalization tool
│
├── # USE LOCAL LLM OR API KEY
│
├── data/
│   └── social-media-comments.json    # NEED a "text" field
│
└── README.md
```

# 🧹 3. Structure JSON

Before running the analysis, you must clean and standardize the JSON using: `restructure-emoji.py`


```

> ✅ This ensures maximum compatibility with the UI and backend.

```

# ▶️ 4. Running the Streamlit Interface

From the project root, run:

```bash
streamlit run ui.py
```

Streamlit will launch and show:

```
Local URL: http://localhost:8501
```

Autoopens / Open the link in your browser.

---

# 🖥️ 5. Using the UI

### Step 1 — Choose Input
Select:

- **Paste text** (one comment per line)  
- **Upload JSON file**  

The UI automatically extracts valid comments.

### Step 2 — Preview
You'll see:

- Number of comments detected  
- First 10 comments for validation  

### Step 3 — Run Analysis
Click:

```
🚀 Run Narrative Analysis
```

The backend produces:

- 🧩 Overall Summary  
- 📚 Dominant Narratives  
- 💬 Example Comments  
- 🧾 JSON Output (download available)

### Step 4 — Export
You can download:

```json
{
  "overall_summary": "...",
  "dominant_narratives": ["...", "..."],
  "example_comments": ["...", "..."]
}
```

---

# ⚙️ 6. Backend Processing Flow

Execution pipeline:

```
Raw Comments → Clean → Chunk → LLM Summaries → Merge → Final Narratives JSON
```

### Internally, the backend:

1. Loads Qwen2.5-7B into GPU memory  
2. Splits comments into manageable chunks  
3. Generates summaries for each chunk  
4. Merges narratives into a single output  
5. Normalizes the output into:
   - One overall summary  
   - 3–6 dominant narratives  
   - 2–5 example comments  

> 🧠 Only clean structured JSON is exposed to the UI.

---

# 📦 7. Requirements

Install dependencies:

```bash
pip install streamlit transformers accelerate torch pydantic
```
