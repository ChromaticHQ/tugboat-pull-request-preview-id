# Tugboat Pull Request Action

This action queries the Tugboat API and get the ID of a preview associated with a given PR.

Note: This action may behave unexpectedly if there are more than one previews associated with a single pull request.

## Inputs

### `tugboat-api-token`

**Required** The Tugboat API token.

### `tugboat-repo-id`

**Required** The Tugboat repository ID.

### `pull-request-number`

**Required** The GitHub pull request number.

## Outputs

### `tugboat-preview-id`

The Tugboat preview ID.

## Example usage

```yaml
jobs:
  rebuild-tugboat-preview:
    runs-on: ubuntu-latest
    container:
      image: tugboatqa/cli
    steps:
      - name: Get the ID of the Tugboat preview associated with this pull request
        id: get-tugboat-preview-id
        uses: chromatichq/tugboat-pull-request-action@v1
        with:
          tugboat-api-token: ${{ secrets.TUGBOAT_API_TOKEN }}
          tugboat-repo-id: ${{ secrets.TUGBOAT_REPO }}
          pull-request-number: ${{ github.event.issue.number }}
      # Use the output from the `get-tugboat-preview-id` step
      - name: Rebuild Tugboat preview
        run: tugboat rebuild ${{ steps.get-tugboat-preview-id.outputs.tugboat-preview-id }}"
```

## Contributing

### Building the Image Locally

To build this image locally on Apple Silicon, use the following command.

```zsh
docker buildx build --platform linux/amd64 -t "tugboat_pr_action:Dockerfile" .
```

### Running the Image Locally

```zsh
docker run -it tugboat_pr_action:Dockerfile <REPLACE_WITH_TUGBOAT_TOKEN> <REPLACE_WITH_TUGBOAT_REPO_ID> <REPLACE WITH PR ID>
```
