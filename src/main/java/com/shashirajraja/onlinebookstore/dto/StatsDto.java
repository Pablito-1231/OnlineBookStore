package com.shashirajraja.onlinebookstore.dto;

public class StatsDto {
    private long totalLibros;
    private long librosDisponibles;
    private long librosAgotados;
    private long totalUsuarios;

    public StatsDto(long totalLibros, long librosDisponibles, long librosAgotados, long totalUsuarios) {
        this.totalLibros = totalLibros;
        this.librosDisponibles = librosDisponibles;
        this.librosAgotados = librosAgotados;
        this.totalUsuarios = totalUsuarios;
    }

    public long getTotalLibros() { return totalLibros; }
    public long getLibrosDisponibles() { return librosDisponibles; }
    public long getLibrosAgotados() { return librosAgotados; }
    public long getTotalUsuarios() { return totalUsuarios; }
}
