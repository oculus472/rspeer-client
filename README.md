# RSPeer Client

RSPeer Client Library Mirror Maven Dependency

# Usage

## Maven

Setup Github Packages settings on your `.m2/settings.xml` see [here](https://help.github.com/en/github/managing-packages-with-github-packages/configuring-apache-maven-for-use-with-github-packages#authenticating-to-github-packages)

```xml
<dependency>
  <groupId>org</groupId>
  <artifactId>rspeer</artifactId>
  <version>2.27</version>
</dependency>
```

## Gradle

```groovy

plugins {
    id 'maven'
}

repositories {
    mavenCentral()
    maven {
        name = "GitHubPackages"
        url = uri("https://maven.pkg.github.com/oculus472/rspeer-client")
        credentials {
            username = System.getenv("GITHUB_USER")
            password = System.getenv("GITHUB_TOKEN")
        }
        metadataSources { artifact() }
    }
}

dependencies {
    compileOnly 'org:rspeer:2.27'
}

```

# Credit

Arbu7as-OSRS for creating the repo.
