#!/usr/bin/env nu

# A wraper to help managing dafos' systems.
def main [...args] {
    # TODO: print usage
}

def "main build" [...args] {
    echo 'running: nh os build --nom .'
    nh os build --nom .
}

def "main switch" [...args] {
    echo 'running: nh os switch --nom .'
    nh os switch --nom .
}
