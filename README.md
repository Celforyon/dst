# Usage
## With docker-compose
### Launch server
`docker-compose up -d`

### View server events
`docker-compose logs -f dst`

### Stop server
`docker-compose down`
or in the game console: `c_shutdown()`

## Without docker-compose
### Launch server
#### First launch
`docker run --name dst -dP -v $CONFDIR:/conf -v $MODSDIR:/mods celforyon/dst`

#### Further launches
`docker start dst`

### View server events
`docker logs -f dst`

### Stop server
`docker stop dst`
or in the game console: `c_shutdown()`
