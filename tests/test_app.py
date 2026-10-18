import pytest
from app import app

@pytest.fixture
def client():
    """Configures the Flask app for testing and provides a test client."""
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_health_endpoint(client):
    """Test that the /health endpoint returns status 200 and correct JSON."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}

def test_index_endpoint(client):
    """Test that the root endpoint returns environment and version data."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.get_json()
    assert "environment" in data
    assert "VERSION" in data
