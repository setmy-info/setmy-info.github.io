# hexo.io

## Information

Hexo is a fast, simple, and powerful static site generator built on Node.js. It uses Markdown (or other markup
languages) to write posts and generates a complete static website from templates and themes. Hexo is commonly used
for technical blogs and documentation sites.

Key characteristics:

* Markdown-based content authoring.
* Extensive theme and plugin ecosystem.
* Built-in deployer plugins for GitHub Pages, FTP, Rsync, and Heroku.
* Fast generation — processes hundreds of posts in seconds.
* Front-matter YAML in posts for metadata (title, date, tags, categories).

## Installation

Node.js LTS is required. See [node.md](node.md) for installation details.

```shell
npm install -g hexo-cli
hexo --version
```

## Preparations

### Initialize a New Blog

```shell
hexo init my-blog
cd my-blog
npm install
```

### Project Structure

```
my-blog/
├── _config.yml          # Site-wide configuration
├── package.json
├── scaffolds/           # Post templates
├── source/
│   ├── _posts/          # Blog post Markdown files
│   └── _drafts/         # Draft posts (not published)
├── themes/              # Installed themes
└── public/              # Generated static site (git-ignored)
```

### Start Development Server

```shell
hexo server
```

Browse to [http://localhost:4000](http://localhost:4000).

### Generate Static Files

```shell
hexo generate
# Short form
hexo g
```

## Configuration

Edit `_config.yml` at the project root for site-wide settings:

```yaml
title: My Blog
subtitle: Notes and thoughts
description: A personal technical blog
author: Your Name
language: en
timezone: Europe/Tallinn

url: https://yourdomain.com

theme: landscape   # theme folder name under themes/
```

### Installing a Theme

```shell
git clone https://github.com/theme-author/theme-name themes/theme-name
```

Then set `theme: theme-name` in `_config.yml`.

## Usage, tips and tricks

### Create a New Post

```shell
hexo new "My Post Title"
# Creates source/_posts/my-post-title.md
```

### Create a Draft

```shell
hexo new draft "Draft Title"
# Publish draft
hexo publish "Draft Title"
```

### Post Front Matter

```yaml
---
title: My Post Title
date: 2024-06-01 12:00:00
tags:
  - devops
  - linux
categories:
  - Tech Notes
---

Post content starts here.
```

### Clean and Regenerate

```shell
hexo clean && hexo generate
```

### Deploy to GitHub Pages

```shell
npm install hexo-deployer-git --save
```

Add to `_config.yml`:

```yaml
deploy:
  type: git
  repo: https://github.com/username/username.github.io
  branch: main
```

Then deploy:

```shell
hexo deploy
# Or combined
hexo g -d
```

## See also

* [hexo.io](https://hexo.io)
* [Hexo themes](https://hexo.io/themes/)
* [Hexo plugins](https://hexo.io/plugins/)
* [Node.js](node.md)
* [npm](npm.md)
