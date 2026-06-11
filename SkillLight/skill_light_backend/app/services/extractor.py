import fitz
import docx
from PIL import Image
import pytesseract
import io

def extract_text(file_bytes: bytes, filename: str):
    ext = filename.split(".")[-1].lower()

    if ext == "pdf":
        return extract_pdf(file_bytes)
    elif ext == "docx":
        return extract_docx(file_bytes)
    elif ext in ["jpg", "jpeg", "png"]:
        return extract_image(file_bytes)
    else:
        return ""

def extract_pdf(file_bytes):
    text = ""
    with fitz.open(stream=file_bytes, filetype="pdf") as doc:
        for page in doc:
            text += page.get_text()
    return text

def extract_docx(file_bytes):
    file_stream = io.BytesIO(file_bytes)
    document = docx.Document(file_stream)
    return "\n".join(p.text for p in document.paragraphs)

def extract_image(file_bytes):
    image = Image.open(io.BytesIO(file_bytes))
    return pytesseract.image_to_string(image)