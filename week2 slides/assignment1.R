library(mgc)
library(reshape2)
library(ggplot2)
require(gridExtra)

plot_sim_func <- function(X, Y, Xf, Yf, name, geom='line') {
  if (!is.null(dim(Y))) {
    Y <- Y[, 1]
    Yf <- Yf[, 1]
  }
  if (geom == 'points') {
    funcgeom <- geom_point
  } else {
    funcgeom <- geom_line
  }
  data <- data.frame(x1=X[,1], y=Y)
  data_func <- data.frame(x1=Xf[,1], y=Yf)
  ggplot(data, aes(x=x1, y=y)) +
    funcgeom(data=data_func, aes(x=x1, y=y), color='red', size=3) +
    geom_point() +
    xlab("x") +
    ylab("y") +
    ggtitle(name) +
    theme_bw()
}

plot_mtx <- function(Dx, Px, main.title="Local Correlation Map (with Optimal Scales)", xlab.title="# X Neighbors", ylab.title="# Y Neighbors") {
  data <- melt(Dx)
  ggplot(data, aes(x=Var1, y=Var2, fill=value)) +
    geom_tile() +
    scale_fill_gradientn(name="l-corr",
                         colours=c("#FFF905", "#F69303", "#ED531B", "#E50026"),
                         limits=c(min(Dx), max(Dx))) +
    xlab(xlab.title) +
    ylab(ylab.title) +
    theme_bw() +
    theme(text = element_text(size=15)) +
    ggtitle(main.title) +
    geom_point(data = Px, color="green", size=5, shape=16)
}

savePlot <- function(myPlot, fileName) {
  jpeg(paste(fileName,".jpg",sep = ""))
  print(myPlot)
  dev.off()
}

set.seed(12345)
#res <- mgc.test(iris[,1], iris[,3], rep=20)

#Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
#colnames(Px) <- c("Var1", "Var2", "value")

#plot_mtx(res$localCorr, Px, main.title="Local Correlation Map",
#         xlab.title="Sepal Length Neighbors", ylab.title="Petal Length Neighbors")

n = 100
d = 1

data <- mgc.sims.linear(n, d)
X <- data$X; Y <- data$Y
func <- mgc.sims.linear(n, d, eps=0)
Xf <- func$X; Yf <- func$Y
plot_sim_func(X, Y, Xf, Yf, "Linear")

res <- mgc.test(X, Y, rep=20)
Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
colnames(Px) <- c("Var1", "Var2", "value")
plot_mtx(res$localCorr, Px)
res$pMGC
res$statMGC

data <- mgc.sims.wshape(n, d)
X <- data$X; Y <- data$Y
func <- mgc.sims.wshape(n, d, eps=0)
Xf <- func$X; Yf <- func$Y
plot_sim_func(X, Y, Xf, Yf, "W")

res <- mgc.test(X, Y, rep=20)
Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
colnames(Px) <- c("Var1", "Var2", "value")
plot_mtx(res$localCorr, Px)
res$pMGC
res$statMGC

data <- mgc.sims.step(n, d)
X <- data$X; Y <- data$Y
func <- mgc.sims.step(n, d, eps=0)
Xf <- func$X; Yf <- func$Y
plot_sim_func(X, Y, Xf, Yf, "Step-Fn")

res <- mgc.test(X, Y, rep=20)
Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
colnames(Px) <- c("Var1", "Var2", "value")
plot_mtx(res$localCorr, Px)
res$pMGC
res$statMGC

data <- mgc.sims.quad(n, d)
X <- data$X; Y <- data$Y
func <- mgc.sims.quad(n, d, eps=0)
Xf <- func$X; Yf <- func$Y
plot_sim_func(X, Y, Xf, Yf, "Quadratic")

res <- mgc.test(X, Y, rep=20)
Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
colnames(Px) <- c("Var1", "Var2", "value")
plot_mtx(res$localCorr, Px)
res$pMGC
res$statMGC

data <- mgc.sims.spiral(n, d)
X <- data$X; Y <- data$Y
func <- mgc.sims.spiral(n=1000, d, eps=0)
Xf <- func$X; Yf <- func$Y
plot_sim_func(X, Y, Xf, Yf, "Spiral", geom='points')

res <- mgc.test(X, Y, rep=20)
Px <- data.frame(list(res$optimalScale$x,res$optimalScale$y,0.0))
colnames(Px) <- c("Var1", "Var2", "value")
plot_mtx(res$localCorr, Px)
res$pMGC
res$statMGC


# grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, ncol=2, widths=unit(c(3,3), c("in", "in")),
#              heights=unit(c(3,3,3,3,3,3,3,3,3,3), c("in", "in", "in", "in", "in", "in", "in", "in", "in", "in")))
