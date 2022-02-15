# rzalamena's gentoo overlay

`ebuild`s I wrote for things that might not yet existing in Gentoo
repositories or never will.

> **NOTE**
>
> I'll mark `ebuild`s stable if they work for me (at least for `amd64`).


## Instructions

1.  Create a directory to place repos (if it doesn't exists):

    ```sh
    mkdir -p /var/db/repos
    ```

2.  Clone the ebuild repository:

    ```sh
    git clone https://github.com/rzalamena/gentoo-overlay.git \
        /var/db/repos/rzalamena
    ```

3.  Copy the repository configuration file:

    ```sh
    cp -v /var/db/repos/rzalamena/rzalamena.conf \
      /etc/portage/repos.conf/rzalamena.conf
    ```

> **NOTE**
>
> You could get the same effect downloading `rzalamena.conf` directly
> into your `/etc/portage/repos.conf` directory and running:
>
> ```sh
> emerge --sync rzalamena
> ```
