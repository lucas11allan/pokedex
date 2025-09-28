import Foundation

// MARK: - Extensions to convert Response to Domain
extension PokemonResponse {
    func toDomain() -> PokemonDetail {
        return PokemonDetail(
            id: id,
            name: name.capitalized,
            imageUrl: sprites?.frontDefault.flatMap { URL(string: $0) },
            types: types?.map { $0.toDomain() },
            stats: stats?.map { $0.toDomain() }
        )
    }
}

extension PokemonTypeResponse {
    func toDomain() -> PokemonType {
        return PokemonType(
            slot: slot,
            type: type.toDomain()
        )
    }
}

extension TypeInfoResponse {
    func toDomain() -> TypeInfo {
        return TypeInfo(
            name: name.capitalized,
            url: url
        )
    }
}

extension PokemonStatResponse {
    func toDomain() -> PokemonStat {
        return PokemonStat(
            baseStat: baseStat,
            stat: stat.toDomain()
        )
    }
}

extension StatInfoResponse {
    func toDomain() -> StatInfo {
        return StatInfo(
            name: name.capitalized,
            url: url
        )
    }
}
