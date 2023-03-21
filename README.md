# Share Post GitHub Action

This GitHub Action is designed to automatically announce new blog posts on
Twitter and Mastodon for Hugo or other static site generator content
repositories. When a new blog post is added to your repository, this action
will generate an announcement text and share it on the specified social media
platforms.

**Note**: This project was completely generated using OpenAI's GPT-4.

## Features

- Automatically generate announcement text based on a template.
- Share new blog posts on Twitter or Mastodon.

## Requirements

- A Hugo or similar static site generator content repository.
- Twitter API keys and access tokens (optional).
- Mastodon instance URL and access token (optional).

## Usage

1. Create a new file called `.github/workflows/share-post.yml` in your content
   repository.
2. Add the following content to the `share-post.yml` file:

```yaml
on:
  push:
    branches:
      - main

jobs:
  share_post:
    runs-on: ubuntu-latest
    steps:
      - uses: punchagan/share-post-action@v1
        with:
          base_url: <YOUR_WEBSITE_BASE_URL>
        env:
          TWITTER_API_KEY: ${{ secrets.TWITTER_API_KEY }}
          TWITTER_API_SECRET_KEY: ${{ secrets.TWITTER_API_SECRET_KEY }}
          TWITTER_ACCESS_TOKEN: ${{ secrets.TWITTER_ACCESS_TOKEN }}
          TWITTER_ACCESS_TOKEN_SECRET: ${{ secrets.TWITTER_ACCESS_TOKEN_SECRET }}
          MASTODON_INSTANCE: ${{ secrets.MASTODON_INSTANCE }}
          MASTODON_ACCESS_TOKEN: ${{ secrets.MASTODON_ACCESS_TOKEN }}
```

3. Replace <YOUR_WEBSITE_BASE_URL> with the base URL of your website.
4. Add your Twitter and Mastodon API keys and access tokens to your
   repository's secrets. You can find more information on how to do this
   [here](https://docs.github.com/en/actions/reference/encrypted-secrets).

## Configuration

### Inputs

| Name                  | Description                                                                                       | Required | Default                             |
|-----------------------|---------------------------------------------------------------------------------------------------|----------|-------------------------------------|
| `base_url`            | The base URL of your website                                                                      | Yes      |                                     |
| `announcement_template`| The template for the announcement text. Use `{{TITLE}}`, `{{POST_URL}}`, `{{TAGS}}`, and `{{DESCRIPTION}}` as placeholders. | No       | `New blog post: {{TITLE}} - {{POST_URL}} {{TAGS}}` |
| `post_subdirectory`   | The subdirectory inside the content folder that contains the blog posts                           | No       | `posts`                             |
