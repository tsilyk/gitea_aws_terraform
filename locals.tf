# --- root/locals.tf ---

locals {
  location = "eu-central-1"

  deployment = {
    Gitea-Pipeline = {
      repo = "tsilyk/gitea"
    }
    /*Repo-2 = {
      repo = "GitHub-Account-Name/Repo-2-Name"
    }
    Repo-3 = {
      repo = "GitHub-Account-Name/Repo-3-Name"
    }
    Repo-4 = {
      repo = "GitHub-Account-Name/Repo-4-Name"
    }*/
  }
}
