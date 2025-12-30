from typing import List
from fastapi import FastAPI, HTTPException
from core.analysis import run_narrative_analysis, AnalysisResult, AnalysisError
from pydantic import BaseModel

app = FastAPI(title="Narrative Analysis API (Qwen2.5-7B)")


class AnalyzeRequest(BaseModel):
    """Defines the input body for the API."""
    comments: List[str]


@app.post("/analyze", response_model=AnalysisResult)
def analyze(req: AnalyzeRequest):
    """
    POST /analyze: Runs narrative analysis on a list of comments.
    """
    result = run_narrative_analysis(req.comments)

    if isinstance(result, AnalysisError):
        raise HTTPException(
            status_code=400,
            detail={
                "error": "LLM output failed JSON validation.",
                "message": result.error_message,
                "raw_output_start": result.raw_output[:200] + "..."
                if result.raw_output
                else "",
            },
        )

    return result

# Run:
# uvicorn app:app --reload