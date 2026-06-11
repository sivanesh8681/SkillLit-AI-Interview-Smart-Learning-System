from openai import OpenAI
import json

client = OpenAI(api_key="YOUR_OPENAI_KEY")

def analyze_resume(resume_text: str):

    prompt = f"""
Analyze this resume and return JSON only with:
1. rating (0-10)
2. best_roles (list)
3. salary_range
4. missing_skills
5. resume_suggestions
6. learning_skills
7. companies (name, address, salary)

Resume:
{resume_text[:6000]}
"""

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.4
    )

    content = response.choices[0].message.content

    try:
        return json.loads(content)
    except:
        return {"error": "GPT_PARSE_FAILED", "raw": content}