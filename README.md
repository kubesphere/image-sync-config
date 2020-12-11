# image-sync-config

This repository persists `image-syncer` configuration files that cover all the docker images used by KubeSphere.

## Synchrizition Directions

### From other registries to Kubesphere

We prefer to push third part images to the KubeSphere namespace on Docker Hub. with less namespace, we can import/export them to a private registry easier. 

### From Kubesphere to Aliyun CR

Aliyun CR is an alternate way for china users to accelerate image download speed.

## Example

#### Image sync configuration file

Image sync configuration file defines all the image synchronization rules, the following is an example of `images.json`

```yaml
# Rules of image synchronization, each rule is a kv pair of source(key) and destination(value). 

# The source of each rule should not be empty string.

# If you need to synchronize images from one source to multi destinations, add more rules.

# Both source and destination are docker image url (registry/namespace/repository:tag), 
# with or without tags.

# For both source and destination, if destination is not an empty string, "registry/namespace/repository" 
# is needed at least.

# You cannot synchronize a whole namespace or a registry but a repository for one rule at most.

# The repository name and tag of destination can be deferent from source, which works like 
# "docker pull + docker tag + docker push"

"quay.io/coreos/kube-rbac-proxy": "quay.io/ruohe/kube-rbac-proxy",
"xxxx":"xxxxx",
"xxx/xxx/xx:tag1,tag2,tag3":"xxx/xxx/xx"

# If a source doesn't include tags, it means all the tags of this repository need to be synchronized,
# destination should not include tags at this moment.

# Each source can include more than one tags, which is split by comma (e.g., "a/b/c:1", "a/b/c:1,2,3").

# If a source includes just one tag (e.g., "a/b/c:1"), it means only one tag need to be synchronized;
# at this moment, if the destination doesn't include a tag, synchronized image will keep the same tag.

# When a source includes more than one tag (e.g., "a/b/c:1,2,3"), at this moment,
# the destination should not include tags, synchronized images will keep the original tags.
# e.g., "a/b/c:1,2,3":"x/y/z".

# When a destination is an empty string, source will be synchronized to "default-registry/default-namespace"
# with the same repository name and tags, default-registry and default-namespace can be set by both parameters
# and environment variable.
```

#### Authentication file

Authentication file holds all the authentication information for each registry, the following is an example of `auth.json`

```java
{               
    // Authentication fields, each object has a URL as key and a username/password pair as value, 
    // if authentication object is not provided for a registry, access to the registry will be anonymous.
        
    "quay.io": {        // This "registry" or "registry/namespace" string should be the same as registry or registry/namespace used below in "images" field.  
                            // The format of "registry/namespace" will be more prior matched than "registry"
        "username": "xxx",             
        "password": "xxxxxxxxx",
        "insecure": true         // "insecure" field needs to be true if this registry is a http service, default value is false, version of image-syncer need to be later than v1.0.1 to support this field
    },
    "registry.cn-beijing.aliyuncs.com": {
        "username": "xxx",
        "password": "xxxxxxxxx"
    },
    "registry.hub.docker.com": {
        "username": "xxx",
        "password": "xxxxxxxxxx"
    },
    "quay.io/coreos": {     // "registry/namespace" format is supported after v1.0.3 of image-syncer     
        "username": "abc",              
        "password": "xxxxxxxxx",
        "insecure": true  
    }
}
```