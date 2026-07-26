# Twenty

## Information

### Introduction

`Twenty` is an open-source Customer Relationship Management (CRM) platform designed to be a modern alternative to
proprietary solutions like Salesforce. It is built with a focus on high performance, modern user experience, and full
data ownership.

Twenty is built using a modern tech stack including TypeScript, React, and Node.js, and it provides a flexible
architecture that allows developers to extend and customize the CRM to fit their specific business needs.

### What is it for?

Twenty is used by companies and individuals who need a robust system to manage their customer relationships, sales
pipelines, and business workflows without being locked into expensive, closed-source ecosystems.

Common use cases include:

* **Sales Pipeline Management**: Tracking leads, deals, and sales activities.
* **Customer Data Management**: Centralizing contact information and interaction history.
* **Workflow Automation**: Automating repetitive tasks and business processes.
* **Self-Hosted CRM**: Maintaining full control over sensitive customer data by hosting the platform on private
  infrastructure.

## Main Functionalities and Features

* **Modern UI/UX**: A clean, intuitive interface inspired by modern productivity tools.
* **Extensible Schema**: Ability to define custom objects and fields to match any business model.
* **Open Source**: Licensed under the AGPL-3.0, allowing for transparency and community contributions.
* **Self-Hostable**: Can be easily deployed using Docker.
* **API-First**: Built with a robust API for easy integration with other tools and services.
* **Real-time Collaboration**: Features designed for team efficiency and shared visibility.

## Installation

The recommended way to install Twenty for production or testing is using Docker Compose.

### Docker Compose

1. **Download the Docker Compose file**:
   You can find the official `docker-compose.yaml` in the Twenty GitHub repository.

2. **Run the stack**:
   ```bash
   docker-compose up -d
   ```

3. **Access the application**:
   Open your browser and navigate to `http://localhost:3000`.

## Usage

### Workspace Setup

After the first launch, you will be prompted to create a workspace and your first administrator account.

### Customizing Objects

One of Twenty's strongest features is its flexibility. You can navigate to the settings to add new objects (e.g.,
"Properties" for real estate or "Projects" for agencies) and define relationships between them.

## See also

* [Twenty Official Website](https://twenty.com/)
* [Twenty GitHub Repository](https://github.com/twentyhq/twenty)
* [Twenty Documentation](https://docs.twenty.com/)
* [UI / UX / GUI](ui-ux-gui.md)
