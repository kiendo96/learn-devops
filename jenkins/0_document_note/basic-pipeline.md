# Defined a pipeline
- A pipeline can be created in one of the following ways:
  + Through Blue Ocean - after setting up a Pipeline project in Blue Ocean, the Blue Ocean UI helps you write your Pipeline’s Jenkinsfile and commit it to source control.
  + Through the classic UI - you can enter a basic Pipeline directly in Jenkins through the classic UI.
  + In SCM - you can write a Jenkinsfile manually, which you can commit to your project’s source control repository

> Detail: https://www.jenkins.io/doc/book/pipeline/getting-started/

# Built-in Documentation
- Pipeline ships with built-in documentation features to make it easier to create Pipelines of varying complexities. This built-in documentation is automatically generated and updated based on the plugins installed in the Jenkins instance.
- The built-in documentation can be found globally at `${YOUR_JENKINS_URL}/pipeline-syntax`. The same documentation is also linked as Pipeline Syntax in the side-bar for any configured Pipeline project.

# Snippet Generator
- The built-in "Snippet Generator" utility is helpful for creating bits of code for individual steps, discovering new steps provided by plugins, or experimenting with different parameters for a particular step.

- The Snippet Generator is dynamically populated with a list of the steps available to the Jenkins instance. The number of steps available is dependent on the plugins installed which explicitly expose steps for use in Pipeline.

> URL using Snippet Generator: ${YOUR_JENKINS_URL}/pipeline-syntax

# Global Variable Reference
- In addition to the Snippet Generator, which only surfaces steps, Pipeline also provides a built-in "Global Variable Reference." Like the Snippet Generator, it is also dynamically populated by plugins. Unlike the Snippet Generator however, the Global Variable Reference only contains documentation for variables provided by Pipeline or plugins, which are available for Pipelines.

- The variables provided by default in Pipeline are:
  + env: `Exposes environment variables, for example: env.PATH or env.BUILD_ID. Consult the built-in global variable reference at ${YOUR_JENKINS_URL}pipeline-syntax/globals#env for a complete, and up to date, list of environment variables available in Pipeline.`
  + params: `Exposes all parameters defined for the Pipeline as a read-only Map, for example: params.MY_PARAM_NAME.`
  + currentBuild: `May be used to discover information about the currently executing Pipeline, with properties such as currentBuild.result, currentBuild.displayName, etc. Consult the built-in global variable reference at ${YOUR_JENKINS_URL}/pipeline-syntax/globals for a complete, and up to date, list of properties available on currentBuild.`

# Declarative Directive Generator
- While the Snippet Generator helps with generating steps for a Scripted Pipeline or for the steps block in a stage in a Declarative Pipeline, it does not cover the sections and directives used to define a Declarative Pipeline. The "Declarative Directive Generator" utility helps with that. Similar to the Snippet Generator, the Directive Generator allows you to choose a Declarative directive, configure it in a form, and generate the configuration for that directive, which you can then use in your Declarative Pipeline.