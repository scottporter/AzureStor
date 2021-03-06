% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/client_endpoint.R
\name{storage_endpoint}
\alias{storage_endpoint}
\alias{endpoint}
\alias{blob_endpoint}
\alias{file_endpoint}
\alias{queue_endpoint}
\alias{table_endpoint}
\alias{adls_endpoint}
\alias{print.storage_endpoint}
\alias{print.adls_endpoint}
\title{Create a storage endpoint object}
\usage{
storage_endpoint(endpoint, key = NULL, token = NULL, sas = NULL, api_version)

blob_endpoint(endpoint, key = NULL, token = NULL, sas = NULL,
  api_version = getOption("azure_storage_api_version"))

file_endpoint(endpoint, key = NULL, token = NULL, sas = NULL,
  api_version = getOption("azure_storage_api_version"))

adls_endpoint(endpoint, key = NULL, token = NULL, sas = NULL,
  api_version = getOption("azure_adls_api_version"))

\method{print}{storage_endpoint}(x, ...)

\method{print}{adls_endpoint}(x, ...)
}
\arguments{
\item{endpoint}{The URL (hostname) for the endpoint. This must be of the form \verb{http[s]://\{account-name\}.\{type\}.\{core-host-name\}}, where \code{type} is one of \code{"dfs"} (corresponding to ADLSgen2), \code{"blob"}, \code{"file"}, \code{"queue"} or \code{"table"}. On the public Azure cloud, endpoints will be of the form \verb{https://\{account-name\}.\{type\}.core.windows.net}.}

\item{key}{The access key for the storage account.}

\item{token}{An Azure Active Directory (AAD) authentication token. This can be either a string, or an object of class AzureToken created by \link[AzureRMR:reexports]{AzureRMR::get_azure_token}. The latter is the recommended way of doing it, as it allows for automatic refreshing of expired tokens.}

\item{sas}{A shared access signature (SAS) for the account.}

\item{api_version}{The storage API version to use when interacting with the host. Defaults to \code{"2019-07-07"}.}

\item{x}{For the print method, a storage endpoint object.}

\item{...}{For the print method, further arguments passed to lower-level functions.}
}
\value{
\code{storage_endpoint} returns an object of S3 class \code{"adls_endpoint"}, \code{"blob_endpoint"}, \code{"file_endpoint"}, \code{"queue_endpoint"} or \code{"table_endpoint"} depending on the type of endpoint. All of these also inherit from class \code{"storage_endpoint"}. \code{adls_endpoint}, \code{blob_endpoint} and \code{file_endpoint} return an object of the respective class.

Note that while endpoint classes exist for all storage types, currently AzureStor only includes methods for interacting with ADLSgen2, blob and file storage.
}
\description{
Create a storage endpoint object, for interacting with blob, file, table, queue or ADLSgen2 storage.
}
\details{
This is the starting point for the client-side storage interface in AzureRMR. \code{storage_endpoint} is a generic function to create an endpoint for any type of Azure storage while \code{adls_endpoint}, \code{blob_endpoint} and \code{file_endpoint} create endpoints for those types.

If multiple authentication objects are supplied, they are used in this order of priority: first an access key, then an AAD token, then a SAS. If no authentication objects are supplied, only public (anonymous) access to the endpoint is possible.
}
\examples{
\dontrun{

# obtaining an endpoint from the storage account resource object
stor <- AzureRMR::get_azure_login()$
    get_subscription("sub_id")$
    get_resource_group("rgname")$
    get_storage_account("mystorage")
stor$get_blob_endpoint()

# creating an endpoint standalone
blob_endpoint("https://mystorage.blob.core.windows.net/", key="access_key")

# using an OAuth token for authentication -- note resource is 'storage.azure.com'
token <- AzureAuth::get_azure_token("https://storage.azure.com",
                                    "myaadtenant", "app_id", "password")
adls_endpoint("https://myadlsstorage.dfs.core.windows.net/", token=token)

}
}
\seealso{
\link{create_storage_account}, \link{adls_filesystem}, \link{create_adls_filesystem}, \link{file_share}, \link{create_file_share}, \link{blob_container}, \link{create_blob_container}
}
