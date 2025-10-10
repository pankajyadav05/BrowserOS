<div align="center">
<img width="693" height="379" alt="github-banner" src="https://github.com/user-attachments/assets/1e37941c-4dbc-4662-9c8c-3bbe9971301d" />

<br></br>
[![Discord](https://img.shields.io/badge/Discord-Join%20us-blue)](https://discord.gg/YKwjt5vuKr)
[![Slack](https://img.shields.io/badge/Slack-Join%20us-4A154B?logo=slack&logoColor=white)](https://dub.sh/browserOS-slack)
[![Twitter](https://img.shields.io/twitter/follow/browserOS_ai?style=social)](https://twitter.com/browseros_ai)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](LICENSE)
<br></br>
<a href="https://files.browseros.com/download/BrowserOS.dmg">
<img src="https://img.shields.io/badge/Download-macOS-black?style=flat&logo=apple&logoColor=white" alt="Download for macOS (beta)" />
</a>
<a href="https://files.browseros.com/download/BrowserOS_installer.exe">
<img src="https://img.shields.io/badge/Download-Windows-0078D4?style=flat&logo=windows&logoColor=white" alt="Download for Windows (beta)" />
</a>
<a href="https://files.browseros.com/download/BrowserOS.AppImage">
<img src="https://img.shields.io/badge/Download-Linux-FCC624?style=flat&logo=linux&logoColor=black" alt="Download for Linux (beta)" />
</a>
<br />

</div>

##

🌐 Mitria is an open-source chromium fork that runs AI agents natively. **Your open-source, privacy-first alternative to Perplexity Comet, Dia**.

🔒 Privacy first - use your own API keys or run local models with Ollama. Your data stays on your computer.

💡 Join our community and help us build! Have feature requests? [Suggest here](https://github.com/browseros-ai/BrowserOS/issues/99).

## Quick start

1. Download and install Mitria:

   - macOS, Windows, and Linux (coming soon)

2. Import your Chrome data (optional)

3. Connect your AI provider (OpenAI, Anthropic, or local models via Ollama/LMStudio)

4. Start automating!

## What makes Mitria special

- 🏠 Feels like home - same familiar interface as Google Chrome, works with all your extensions
- 🤖 AI agents that run on YOUR browser, not in the cloud
- 🔒 Privacy first - bring your own keys or use local models with Ollama. Your browsing history stays on your computer
- 🚀 Open source and community driven - see exactly what's happening under the hood
- 🤝 MCP store to one-click install popular MCPs and use them directly in the browser bar
- 🛡️ (coming soon) Built-in AI ad blocker that works across more scenarios!

## Demos

### 🤖 Mitria agent in action

See how Mitria's AI agents can automate your browsing tasks seamlessly.

<br/><br/>

### 💬 Use Mitria to chat

Chat with AI directly in your browser with full context of your browsing session.

<br/><br/>

### ⚡ Use Mitria to scrape data

Automate data extraction from websites with intelligent AI agents.

<br/><br/>

## Why We're Building Mitria

For the first time since Netscape pioneered the web in 1994, AI gives us the chance to completely reimagine the browser. We've seen tools like Cursor deliver 10x productivity gains for developers—yet everyday browsing remains frustratingly archaic.

You're likely juggling 70+ tabs, battling your browser instead of having it assist you. Routine tasks, like ordering something from amazon or filling a form should be handled seamlessly by AI agents.

At Mitria, we're convinced that AI should empower you by automating tasks locally and securely—keeping your data private. We are building the best browser for this future!

## How we compare

<details>
<summary><b>vs Chrome</b></summary>
<br>
While we're grateful for Google open-sourcing Chromium, but Chrome hasn't evolved much in 10 years. No AI features, no automation, no MCP support.
</details>

<details>
<summary><b>vs Brave</b></summary>
<br>
We love what Brave started, but they've spread themselves too thin with crypto, search, VPNs. We're laser-focused on AI-powered browsing.
</details>

<details>
<summary><b>vs Arc/Dia</b></summary>
<br>
Many loved Arc, but it was closed source. When they abandoned users, there was no recourse. We're 100% open source - fork it anytime!
</details>

<details>
<summary><b>vs Perplexity Comet</b></summary>
<br>
They're a search/ad company. Your browser history becomes their product. We keep everything local.
</details>

## Contributing

We'd love your help making Mitria better!

- 🐛 [Report bugs](https://github.com/codifyit/mitria/issues)
- 💡 [Suggest features](https://github.com/codifyit/mitria/issues)

## License

Mitria is open source under the [AGPL-3.0 license](LICENSE).

## Stargazers

Thank you to all our supporters!

[![Star History Chart](https://api.star-history.com/svg?repos=browseros-ai/BrowserOS&type=Date)](https://www.star-history.com/#browseros-ai/BrowserOS&Date)

##

## Check patches

bash apply-all-patches.sh ~/chromium/src

powershell -ExecutionPolicy Bypass -File apply-all-patches.ps1 B:\projects\chromium\src

## Clear directory

git reset --hard HEAD ; git clean -fd

git reset --hard HEAD && git clean -fd
