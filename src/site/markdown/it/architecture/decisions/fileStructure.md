# File Structure (Standard)

DRAFT

Data storage locations prefixes:

* **/var/opt/setmy.info**

* **/var/opt/setmy.info/gintra** == **/mnt/gintra** (smi-gintra-mount-location)

* **/var/opt/setmy.info/nfs-root** (root folder for disk-less NFS)

* **/var/opt/setmy.info/nfs-XYZ** (Other NFS folders for disk-less NFS. XYZ = [boot|home|MACHINE_NAME])

* **/tank**

* **/gintra**

Sub structures (relations to LDAP):

* **PREFIX/organizations/COUNTRY_CODE/ORG_SHORT_NAME/DEPARTMEND_NAME**
    * documents
    * pictures
    * videos
    * cdn
    * dvc
    * downloads
        * torrent
    * software
        * packages
        * rpms (For example: [https://rpms.has.gintra](https://rpms.has.gintra))
        * maven
        * pypi
        * clojars
        * lisp
        * opt
        * tftp
    * configuration
        * pki
            * ca
    * scm
        * git
            * www
            * intranet
            * tor
            * dweb
        * mercurial
        * svn
    * ml
        * data
            * input
                * raw
                * processed
                * training
                * testing
                * validation
                * externale
                * labels
                * augmentation
                * splits
                * exploration
                * data-sources
            * output
                * parameters
                * models
                * weights
                * reports
                * generated
                * snapshots
    * persons
        * person_hash_d41a45dce7c4e41cf118e7a8c2
            * pub
            * priv

```shell
# /var/opt/setmy.info/gintra/organizations/ee/has
smi-organization-location ee has
```

**PREFIX/persons/COUNTRY_CODE/HASH**

```shell
# /var/opt/setmy.info/gintra/persons/person_hash_d41a45dce7c4e41cf118e7a8c2
smi-person-location "John Doe"
```
