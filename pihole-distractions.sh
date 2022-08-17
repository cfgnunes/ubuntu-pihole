#!/usr/bin/env bash

# Script for enabling/disabling distracting websites
#
# Author: Cristiano Fraga G. Nunes <cfgnunes@gmail.com>

set -eu

SCRIPT_NAME=$(basename "$0")

_main() {
    _log "Starting..."

    # (entertainment, social, news, memes)
    pihole --regex "$@" \
        "*4chan*" \
        "*9gag*" \
        "*bbc.com*" \
        "*blogger.com*" \
        "*bloomberg.com*" \
        "*buzzfeed*" \
        "*cbssports.com*" \
        "*cnbc.com*" \
        "*cnet.com*" \
        "*cnn.com*" \
        "*cnnbrasil.com*" \
        "*coinbase.com*" \
        "*coinmarketcap.com*" \
        "*collegehumor.com*" \
        "*cracked.com*" \
        "*craigslist.org*" \
        "*deviantart*" \
        "*digg.com*" \
        "*economist.com*" \
        "*elpais.com*" \
        "*em.com*" \
        "*engadget.com*" \
        "*espn.com*" \
        "*estadao.com*" \
        "*etsy.com*" \
        "*facebook*" \
        "*fark.com*" \
        "*fbcdn*" \
        "*fbsbx*" \
        "*flickr*" \
        "*forbes.com*" \
        "*foxnews.com*" \
        "*foxsports.com*" \
        "*funnyordie.com*" \
        "*gigaom.com*" \
        "*gizmodo.com*" \
        "*globo.com*" \
        "*googlevideo*" \
        "*huffingtonpost.com*" \
        "*hulu.com*" \
        "*ifunny*" \
        "*imdb.com*" \
        "*instagram*" \
        "*investing.com*" \
        "*jovempan.com*" \
        "*leiaja.com*" \
        "*lifehacker.com*" \
        "*linkedin*" \
        "*liveleak.com*" \
        "*macrumors.com*" \
        "*mashable.com*" \
        "*meetup.com*" \
        "*metafilter.com*" \
        "*mlb.com*" \
        "*moneytimes.com*" \
        "*msnbc.com*" \
        "*nba.com*" \
        "*nbcnews.com*" \
        "*netflix*" \
        "*news.google.com*" \
        "*news.ycombinator.com*" \
        "*nfl.com*" \
        "*nhl.com*" \
        "*noticias.yahoo.com*" \
        "*npr.org*" \
        "*nytimes.com*" \
        "*olhardigital.com*" \
        "*pinterest*" \
        "*poder360.com*" \
        "*popurls.com*" \
        "*producthunt.com*" \
        "*r7.com*" \
        "*readwrite.com*" \
        "*recode.net*" \
        "*reddit*" \
        "*rottentomatoes.com*" \
        "*slashdot.org*" \
        "*snapchat*" \
        "*soundcloud.com*" \
        "*techcrunch.com*" \
        "*techmeme.com*" \
        "*tecmundo.com*" \
        "*ted.com*" \
        "*terra.com*" \
        "*theguardian.com*" \
        "*thenextweb.com*" \
        "*theonion.com*" \
        "*theverge.com*" \
        "*tiktok*" \
        "*time.com*" \
        "*tmz.com*" \
        "*tomshardware.com*" \
        "*torcedores.com*" \
        "*tumblr*" \
        "*twitch*" \
        "*twitter*" \
        "*uol.com*" \
        "*usatoday.com*" \
        "*veja.abril.com*" \
        "*venturebeat.com*" \
        "*vice.com*" \
        "*vimeo.com*" \
        "*washingtonpost.com*" \
        "*wired.com*" \
        "*wsj.com*" \
        "*xpi.com*" \
        "*youtube*" \
        "*zdnet.com*"

    _log "Done!"
}

_log() {
    local STR_MESSAGE=$1

    logger -s "[$SCRIPT_NAME] $STR_MESSAGE"
}

_main "$@"
