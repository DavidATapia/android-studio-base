# android-base
Provides the base Docker image used by [android-builder](https://github.com/DavidATapia/android-builder).  The ":latest" tag is active on the most recent image built from 'main'.

## Read Access to GHCR
Generally, these images are referenced elsewhere in another Dockerfile using `FROM ghcr.io/DavidATapia/android-base:latest`.

Login to Hellbender GHCR before trying to pull these images.  To login, [create a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token) having at least "read" package repository priviledges.  Then:

```
echo <PersonnelAccessToken> | docker login ghcr.io -u <Github-Username> --password-stdin
```

## Continuous Integration
CI runs under two conditions: pushes to any branch in PR review (including drafts) and for merges into 'main'.

## Building
CI handles building and pushing new images to the [Github Container Registry (GHCR)](https://github.com/DavidATapia/android-base/pkgs/container/android-base)triggered from a merge to 'main' .  The CI also validates branches in PR review -- but does not push those built images to GHCR.  Only 'main' builds are pushed to GHCR having the ":latest" tag applied.

To create images locally for testing:
```
docker build -t mytest:testing .
```

and reference using:
```
FROM mytest:testing
```

## Rollback latest tag
To apply the ":latest" tag to any previous image in the registry, first [create a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token) having "write" package repository permissions and login to GHCR with that token.  Use the sha256 digest of an image you want to add a tag to; see an example command below:
```
docker manifest create ghcr.io/DavidATapia/android-base:latest ghcr.io/DavidATapia/android-base@sha256:2d8113dde085054365d5be686912ecd20fbbc74a18701e7d2aed495b97ab5654
docker manifest push ghcr.io/DavidATapia/android-base:latest
```
