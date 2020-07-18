from typing import Optional

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    """
    The Root Router
    :return: dict
    """
    return {"Hello": "World from Utsav"}


@app.get("/items/{item_id}")
def read_item(item_id: int, query_param: Optional[str] = None):
    """
    Method to get item
    :param item_id: int
    :param query_param: str
    :return: dict
    """
    return {"item_id": item_id, "q": query_param}
