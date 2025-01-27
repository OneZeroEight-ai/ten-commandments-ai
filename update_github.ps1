# update_github.ps1

# Add all new files
git add .

# Create commit with clear message
git commit -m "Add working minimal implementation with ethical loan example
- Add commandments package with basic implementation
- Add working smart loan example
- Fix package structure and installation
- Add ethical checks for equity, harm prevention, and value alignment"

# Push to GitHub
git push origin main

Write-Host "Changes have been pushed to GitHub at: https://github.com/OneZeroEight-ai/ten-commandments-ai"