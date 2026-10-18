




=============================================================================
# Flask Application Environment Variables (Development)
# Flask Application Environment Variables (Production)
==============================================================================
How to use them in your workspace:
You can quickly create your active configuration files from these templates by running these commands in your terminal:

Bash
cp config/development_env.example .env

You should use this command when setting up your project for the first time on a new computer or after cloning your repository from GitHub.

Here is why and when it is used in a professional workflow:

Why We Use It
Protecting Secrets (The .gitignore Rule):
Your real .env file contains configuration settings (and sometimes database passwords or API keys). You never want to commit your real .env file to GitHub. By using an .example file, you share the structure of what variables are needed without exposing any real data.

Instant Local Setup:
When someone downloads your code, instead of guessing what environment variables the app needs, they just copy the example file into a real .env file and customize it.

When Exactly to Run It in Your Workflow
You run this command before starting your application locally if your app reads settings from a .env file:

Clone or open your repository.

Run cp config/development_env.example .env to create your local working file.

Activate your virtual environment and run your app.

===================================================
How to Test Your Dockerfile
===================================================
Run these commands from your root directory (devops_portfolio):

Bash
# 1. Build the Docker image from root context using the docker/Dockerfile
docker build -t devops-portfolio:v1 -f docker/Dockerfile .

# 2. Run the container in detached mode mapping port 5000
docker run -d -p 5000:5000 --name portfolio-app devops-portfolio:v1

# 3. Test the endpoints
curl http://localhost:5000/health
curl http://localhost:5000/
-------------------------------------------------------------------------------------------------------

===================================================
File: scripts/bash/health_check.sh
==================================================
How to Make and Test Your Script
Once you save the file, you need to grant it execution permissions in Linux before running it:

Bash
# 1. Make the script executable
chmod +x scripts/bash/health_check.sh

# 2. Test it while your container is running
./scripts/bash/health_check.shHow to Make and Test Your Script
Once you save the file, you need to grant it execution permissions in Linux before running it:

Bash
# 1. Make the script executable
chmod +x scripts/bash/health_check.sh

# 2. Test it while your container is running
./scripts/bash/health_check.sh
--------------------------------------------------------------------------------------------


===============================================
HOW TO RUN IN .VENV
==================================================
🛠️ Step-by-Step Execution Guide
1. Navigate to Project Root
Make sure terminal is in the root directory (devops_portfolio):

Bash
cd ~/devops_portfolio
2. Activate Your Virtual Environment
Bash
source .venv/bin/activate
(You should now see (.venv) displayed at the start of your terminal prompt line.)

3. Install Development Dependencies
Install both app dependencies and testing tools into the .venv:

Bash
pip install -r requirements_dev.txt
4. Set Environment Variables
Export variables from config/development_env.example into your active shell session:

Bash
export APP_ENV=development
export APP_VERSION=1.0.0
export FLASK_APP=src/app.py
export FLASK_DEBUG=1
export PYTHONPATH=$PYTHONPATH:$(pwd)/src
5. Start the Flask Application
Run the application directly:

Bash
python3 src/app.py
(You will see output indicating Flask is running on [http://127.0.0.1:5000](http://127.0.0.1:5000) or [http://0.0.0.0:5000](http://0.0.0.0:5000).)

🧪 Step 6: Verify the Running App (Second Terminal Window)
Open a new terminal tab or window, navigate to devops_portfolio, and execute the health check script we wrote:

Bash
cd ~/devops_portfolio
chmod +x scripts/bash/health_check.sh
./scripts/bash/health_check.sh
You can also run Pytest to verify your test suite:

Bash
source .venv/bin/activate
pytest
--------------------------------------------------------


