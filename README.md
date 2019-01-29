# An Angular testing container

## Introduction

I wanted a docker.io container to do my automated CI / CD testing with GitLab.  Thought it smart to have it closely resemble the deployment server.

There are likely more space-efficient containers out there, but this one is mine.

## Installation

Based on `ubuntu:latest`, contains:

* curl, git, rsync
* gitlab-runner
* nodejs
* chromium-browser
* @angular/cli

Use `$ docker pull agkay/angular-karma-chrome` to get it!

## Configuration

### Karma

Make sure your karma.conf.js is configured correctly.

Add `karma-chrome-launcher` to your plugins array

````typescript
    plugins: [
      require('karma-jasmine'),
      require('karma-chrome-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage-istanbul-reporter'),
      require('@angular-devkit/build-angular/plugins/karma')
    ],
````

Create a custom launcher and set the `--no-sandbox` option.

````typescript
    browsers: ['ChromeHeadlessCI'],
    customLaunchers: {
      ChromeHeadlessCI: {
        base: 'ChromeHeadless',
        flags: ['--no-sandbox']
      }
    },
````

### GitLab

If you use the supplied gitlab-ci.yml to perform a deploy, you will want to define the following environment variables:

* `DEPLOY_SSH_KEY`  Provide a private key with access to your production server,
* `DEPLOY_SSH_USER`  Tell us what account to do it with,
* `DEPLOY_SSH_HOST`  Where the server is,
* `DEPLOY_SSH_DIR`  And where on the disk you want it to go.
