# New Project KB

This command guides you through setting up a new client project knowledge base — copying the template, creating the local folder structure, and optionally creating or updating a GitHub repo.

---

## Step 1: Check prerequisites

Run the following checks silently before speaking to the user. You'll use the results to decide what guidance to give.

### 1a. Check git is installed
```bash
git --version
```

### 1b. Check git identity is configured
```bash
git config --global user.name
git config --global user.email
```

### 1c. Check GitHub CLI is installed
```bash
gh --version
```

### 1d. Check GitHub CLI is authenticated
```bash
gh auth status
```

---

## Step 2: Fix any missing prerequisites

Work through each issue in plain language. These instructions are written for people who may be new to the terminal.

### If git is not installed

Tell the user:

> Git isn't installed on your machine yet. Here's how to install it:
>
> 1. Open your Terminal app (you can find it by pressing **Cmd + Space** and typing "Terminal")
> 2. Type the following and press Enter:
>    ```
>    xcode-select --install
>    ```
> 3. A window will pop up asking you to install developer tools — click **Install** and wait for it to finish (it takes a few minutes)
> 4. Once done, come back here and I'll continue the setup

Wait for the user to confirm before continuing.

### If git is installed but user.name or user.email is not set

Tell the user:

> Git needs to know your name and email so it can label your work correctly. You'll need to run these two commands in your Terminal — replace the example values with your own:
>
> ```bash
> git config --global user.name "Your Name"
> git config --global user.email "your.email@example.com"
> ```
>
> Use the same email address you use for GitHub. Once you've done that, come back here and I'll carry on.

Wait for the user to confirm before continuing. Do **not** ask the user to type their name or email into this chat — they should enter them directly in the terminal.

### If GitHub CLI (gh) is not installed

Tell the user:

> The GitHub CLI (`gh`) is a tool that lets us create and manage GitHub repos from the terminal. Here's how to install it:
>
> 1. If you don't have Homebrew installed, first run:
>    ```bash
>    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
>    ```
>    Follow any on-screen instructions. If it asks for your Mac password, type it and press Enter (the characters won't show — that's normal).
>
> 2. Then install the GitHub CLI:
>    ```bash
>    brew install gh
>    ```
>
> Once done, come back here and I'll continue.

Wait for confirmation before continuing.

### If gh is installed but not authenticated

Tell the user:

> You need to connect the GitHub CLI to your GitHub account. Run this command in your Terminal:
>
> ```bash
> gh auth login
> ```
>
> It will ask you a few questions:
> - **Where do you use GitHub?** → Choose **GitHub.com**
> - **What is your preferred protocol?** → Choose **HTTPS**
> - **How would you like to authenticate?** → Choose **Login with a web browser**
>
> It will give you a code and open a browser window. Paste the code in, log in, and click **Authorise**. Then come back here.

Wait for confirmation before continuing.

---

## Step 3: Get client and project name

Before asking the user, capture the current working directory:

```bash
pwd
```

Store this as `BASE_DIR`.

Once all prerequisites are confirmed, ask the user:

> Now let's set up the project. I need two things:
>
> **1. Client name** — this will be used as part of the GitHub repo name, so keep it short and simple. No spaces — use hyphens if needed (e.g. `FanDuel`, `HSBC`, `John-Lewis`).
>
> **2. Project name** — same rule applies. This will be a folder inside the client's repo (e.g. `platform-strategy`, `data-migration`, `phase-2`).

Store the responses as `CLIENT_NAME` and `PROJECT_NAME`.

Confirm back to the user:
> Got it. I'll set up:
> - **Repo:** `deliveryKB-CLIENT_NAME` (under the xSolutions365 org)
> - **Project folder:** `PROJECT_NAME`
> - **Local path:** `BASE_DIR/CLIENT_NAME/PROJECT_NAME`
>
> Does that look right?

Wait for confirmation.

---

## Step 4: Copy the template

Clone the template repo to a temporary location, copy the `exampleProject` folder, then clean up:

```bash
# Clone the template (shallow — we only need the files, not the history)
git clone --depth 1 https://github.com/xSolutions365/delivery-kb-template.git /tmp/delivery-kb-template

# Create the local destination
mkdir -p BASE_DIR/CLIENT_NAME/PROJECT_NAME

# Copy the example project files across
cp -r /tmp/delivery-kb-template/exampleProject/. BASE_DIR/CLIENT_NAME/PROJECT_NAME/

# Clean up the temp clone
rm -rf /tmp/delivery-kb-template
```

Confirm to the user:
> Template copied. Your new KB is at `BASE_DIR/CLIENT_NAME/PROJECT_NAME`.

---

## Step 5: Ask about creating a GitHub repo

Ask the user:

> Would you like me to set this up in GitHub? I'll create a private repo called `deliveryKB-CLIENT_NAME` under the xSolutions365 org (or add to it if it already exists).

If they say **no**, skip to Step 7.

---

## Step 6: Create or update the GitHub repo

### Check if the repo already exists

```bash
gh repo view xSolutions365/deliveryKB-CLIENT_NAME --json name 2>/dev/null
```

**If the repo does NOT exist** (command returns an error):

```bash
# Initialise git in the local folder
cd BASE_DIR/CLIENT_NAME
git init
git branch -M main

# Add a .gitignore
echo ".DS_Store" >> .gitignore

# Create the private repo in the xSolutions365 org and push
gh repo create xSolutions365/deliveryKB-CLIENT_NAME --private --source=. --remote=origin --push
```

Tell the user:
> Created a new private repo: `xSolutions365/deliveryKB-CLIENT_NAME`. Your project has been pushed.

**If the repo DOES exist:**

```bash
# Clone the existing repo
git clone https://github.com/xSolutions365/deliveryKB-CLIENT_NAME.git BASE_DIR/CLIENT_NAME
```

Then move the project folder into it (if it was created outside the clone):

```bash
# If the project was already created inside the cloned folder, skip this
# Otherwise copy it in:
cp -r BASE_DIR/CLIENT_NAME/PROJECT_NAME BASE_DIR/CLIENT_NAME/
```

Then commit and push:

```bash
cd BASE_DIR/CLIENT_NAME
git add PROJECT_NAME/
git commit -m "Add PROJECT_NAME project KB"
git push
```

Tell the user:
> The repo `xSolutions365/deliveryKB-CLIENT_NAME` already exists — added `PROJECT_NAME` as a new folder and pushed.

---

## Step 7: Wrap up

Tell the user:

> All done! Here's a summary of what was set up:
>
> - **Local KB:** `BASE_DIR/CLIENT_NAME/PROJECT_NAME`
> - **GitHub repo:** `https://github.com/xSolutions365/deliveryKB-CLIENT_NAME` *(if created)*
>
> **Next steps:**
> 1. Open the KB in your editor or Obsidian from `BASE_DIR/CLIENT_NAME/PROJECT_NAME`
> 2. Start filling in `01-project-overview/high-level-brief.md` with your project details
> 3. Run the **setup-changelog-hook** skill (from inside the project folder in Claude Code) to enable automatic changelog tracking
>
> **Reminder:** The KB template files all contain `[placeholder]` values — replace them as you learn more about the project. It's better to leave `[TBC]` than to guess.
