# ============================================
# KPI Cards con Kruskal-Wallis + Epsilon^2
# ============================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
})

# ---- Limpieza básica ---------------------------------------------------------
# - Quita duplicados
# - Filtra NAs en la métrica y el grupo
# - Enforce: group como factor
clean_base <- function(df, metric, group){
  stopifnot(metric %in% names(df), group %in% names(df))
  df %>%
    distinct() %>%
    select(all_of(c(metric, group))) %>%
    filter(!is.na(.data[[metric]]), !is.na(.data[[group]])) %>%
    mutate(
      !!group := as.factor(.data[[group]]),
      !!metric := as.numeric(.data[[metric]])
    )
}

# ---- Filtro de outliers (IQR) -----------------------------------------------
# Global por métrica. Si quieres por grupo, especifica group != NULL.
iqr_filter <- function(df, metric, by_group = FALSE, group = NULL, k = 1.5){
  x <- df
  if(by_group && !is.null(group)){
    x <- x %>%
      group_by(.data[[group]]) %>%
      mutate(
        Q1 = quantile(.data[[metric]], 0.25, na.rm = TRUE),
        Q3 = quantile(.data[[metric]], 0.75, na.rm = TRUE),
        IQR = Q3 - Q1
      ) %>%
      filter(.data[[metric]] > (Q1 - k*IQR), .data[[metric]] < (Q3 + k*IQR)) %>%
      ungroup() %>%
      select(-Q1,-Q3,-IQR)
  } else {
    Q1 <- quantile(x[[metric]], 0.25, na.rm = TRUE)
    Q3 <- quantile(x[[metric]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    x <- x %>%
      filter(.data[[metric]] > (Q1 - k*IQR), .data[[metric]] < (Q3 + k*IQR))
  }
  x
}

# ---- Epsilon^2 para Kruskal-Wallis ------------------------------------------
epsilon2_kw <- function(H, n, k){
  # H: estadístico Kruskal-Wallis (numérico)
  # n: tamaño muestral total
  # k: número de grupos
  # Fórmula común (Tomczak & Tomczak, 2014)
  as.numeric((H - k + 1) / (n - k))
}

# ---- Tarjeta KPI (solo texto) ------------------------------------------------
# label_mode:
#   - "variance": "% of variance explained by groups" (recomendado)
#   - "relative":  "% more <what>" (si necesitas el wording original)
kw_kpi_card <- function(df, metric, group,
                        remove_outliers = FALSE,
                        outliers_by_group = FALSE,
                        k_iqr = 1.5,
                        label_mode = c("variance","relative"),
                        relative_noun = "value",
                        text_color = "brown3",
                        text_size = 15){
  label_mode <- match.arg(label_mode)

  # Limpieza base
  data_clean <- clean_base(df, metric, group)

  # (Opcional) outliers
  if(remove_outliers){
    data_clean <- iqr_filter(data_clean, metric,
                             by_group = outliers_by_group, group = group, k = k_iqr)
  }

  # Kruskal-Wallis
  kw <- kruskal.test(formula = as.formula(paste(metric, "~", group)), data = data_clean)

  H <- as.numeric(kw$statistic)
  k_groups <- length(unique(data_clean[[group]]))
  n_total  <- nrow(data_clean)

  eps2 <- epsilon2_kw(H, n_total, k_groups)
  eps2_pct <- round(100 * eps2, 2)
  pval <- kw$p.value

  # Etiqueta
  label <- if (label_mode == "variance") {
    paste0(eps2_pct, "% variance explained by groups\n",
           "(Kruskal-Wallis p=", format.pval(pval, digits = 3), ")")
  } else {
    paste0(eps2_pct, "% more ", relative_noun, "\n",
           "(Kruskal-Wallis p=", format.pval(pval, digits = 3), ")")
  }

  # Plot tarjeta
  output_df <- data.frame(label = label)
  p <- ggplot(output_df, aes(x = 1, y = 1, label = label)) +
    geom_text(size = text_size, color = text_color, lineheight = 0.95) +
    theme_void() +
    theme(
      plot.margin = margin(0,0,0,0),
      plot.background = element_rect(fill = "white", color = NA)
    )

  list(
    data = data_clean,
    k = k_groups,
    n = n_total,
    kw = kw,
    epsilon2 = eps2,
    epsilon2_pct = eps2_pct,
    p_value = pval,
    plot = p
  )
}
