# manifest

[![Current Tag](https://img.shields.io/github/v/tag/actionhippie/manifest?sort=semver)](https://github.com/actionhippie/manifest) [![Docker Build](https://github.com/actionhippie/manifest/workflows/docker/badge.svg)](https://github.com/actionhippie/manifest/actions/workflows/docker.yml)

[GitHub Action](https://github.com/features/actions) to upload Docker image manifests.

## Usage

```yml
name: Example

on:
  - push
  - pull_request

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - uses: actionhippie/manifest@v1
        with:
          username: octocat
          password: p455w0rd
          platforms: linux/amd64,linux/arm64,linux/arm
          template: foo/bar-ARCH:v1
          target: foo/bar:v1
          ignore_missing: true
```

## Inputs

### `username`

Username for the used registry

### `password`

Password for the used registry

### `insecure`

Enable insecure access to the used registry, defaults to `false`

### `debug`

Enable debug output for manifest-tool, defaults to `false`

### `spec`

Path manifest file in YAML format

### `platforms`

List of the platforms that images should be pushed for

### `template`

Pattern the source images have, OS and ARCH will be replaced

### `target`

Name of the manifest list image that is going to be produced

### `ignore_missing`

Only warn on missing images defined in spec or list, defaults to `false`

## Outputs

None

## Security

If you find a security issue please contact thomas@webhippie.de first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

* [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2021 Thomas Boerger <thomas@webhippie.de>
```
