# Sealion
A fast, easy-to-use client for Digital Ocean API v2 written in Swift.

### Getting started
Create and initialize the API client using a version `enum` and your Digital Ocean personal access token.
```swift
let api = API(version: .v2, token: "a4b2f1b7e1f10dab178375189f2a285a18abee5f4e353dcfedae7087e9e25463")
```

### Example usage
In this example we fetch a list of droplets and create a snapshot for every droplet that doesn't have `backups` enabled.
```swift
api.droplets { result in
    switch result {
    case .success(let droplets):
        
        guard let droplets = droplets else {
            return
        }
        
        for droplet in droplets where !droplet.features.contains("backups") {
            createSnapshotFor(droplet.id)
        }
        
    case .failure(let error, let reason):
        print("Error fetching droplets: \(error) - \(reason)")
    }    
}
```
