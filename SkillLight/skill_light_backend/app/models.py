from sqlalchemy import Column, Integer, String, Boolean, DateTime, JSON
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()

class Session(Base):
    __tablename__ = "sessions"
    id = Column(String, primary_key=True, index=True)
    user_id = Column(Integer, nullable=True)   # optional for Day1
    role = Column(String, nullable=True)
    difficulty = Column(String, nullable=True)
    created_at = Column(DateTime, server_default=func.now())
    data = Column(JSON, default={})
