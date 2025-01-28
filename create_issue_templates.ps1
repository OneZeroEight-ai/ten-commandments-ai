# create_issue_templates.ps1

# Create issue templates directory
New-Item -Path ".github/ISSUE_TEMPLATE" -ItemType Directory -Force

# Create bug report template
@'
---
name: Bug Report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''

---

**Describe the Bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Import module '...'
2. Call function '....'
3. Pass parameters '....'
4. See error

**Expected Behavior**
A clear description of what you expected to happen.

**Actual Behavior**
What actually happened.

**Code Example**
```python
# Minimal code example that reproduces the issue
```

**Environment**
- Python version:
- Package version:
- OS:

**Additional Context**
Add any other context about the problem here.
'@ | Out-File -FilePath ".github/ISSUE_TEMPLATE/bug_report.md" -Encoding ASCII

# Create feature request template
@'
---
name: Feature Request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''

---

**Related Commandment**
Which of the Ten Commandments does this feature relate to?

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I need to evaluate [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Example Usage**
```python
# Example of how you would like to use this feature
```

**Ethical Considerations**
Describe any ethical implications or considerations for this feature.

**Additional context**
Add any other context or screenshots about the feature request here.
'@ | Out-File -FilePath ".github/ISSUE_TEMPLATE/feature_request.md" -Encoding ASCII

# Create enhancement request template
@'
---
name: Enhancement Suggestion
about: Suggest an enhancement to existing functionality
title: '[ENHANCEMENT] '
labels: enhancement
assignees: ''

---

**Which component would you like to enhance?**
- [ ] EquityMetrics
- [ ] HarmPrevention
- [ ] ValueAlignment
- [ ] Documentation
- [ ] Tests
- [ ] Other

**Describe the enhancement**
A clear description of what you want to improve.

**Current Behavior**
What is the current behavior?

**Desired Behavior**
What is the behavior you would like to see?

**Example Implementation**
```python
# Optional: Example code showing how this might work
```

**Ethical Implications**
Describe any ethical considerations for this enhancement.
'@ | Out-File -FilePath ".github/ISSUE_TEMPLATE/enhancement.md" -Encoding ASCII

# Create documentation improvement template
@'
---
name: Documentation Improvement
about: Suggest improvements to our documentation
title: '[DOCS] '
labels: documentation
assignees: ''

---

**Which documentation needs improvement?**
Specify which documentation needs to be updated.

**What is the current documentation issue?**
Describe what is unclear, missing, or incorrect.

**What improvements would you like to see?**
Describe the improvements you'd like to see.

**Additional context**
Add any other context or examples here.
'@ | Out-File -FilePath ".github/ISSUE_TEMPLATE/documentation.md" -Encoding ASCII

# Create issue template config
@'
blank_issues_enabled: false
contact_links:
  - name: Ten Commandments for AI Book
    url: https://a.co/d/2oH8YZT
    about: Learn more about the principles behind this implementation
  - name: GitHub Discussions
    url: https://github.com/OneZeroEight-ai/ten-commandments-ai/discussions
    about: Please ask and answer questions here
'@ | Out-File -FilePath ".github/ISSUE_TEMPLATE/config.yml" -Encoding ASCII

# Create git commit
git add .
git commit -m "Add issue templates for bugs, features, enhancements, and documentation"
git push origin main

Write-Host "Issue templates have been created and pushed to the repository"