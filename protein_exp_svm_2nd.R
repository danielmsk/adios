
library(caret)
library(e1071)

d <- read.table("st16_data_human_1305_proteins.txt", sep='\t', header=T)

## index
male_idx <- which(d$Sex=="Male")
female_idx <- which(d$Sex=="Female")
all_idx <- which(d$Age > 0)
cn = colnames(d)
protidx <- c(5:(length(d[1,])))
# nprotein <- length(d[1,]) - 4
nprotein <- length(d[1,])


sex_group1 <- rep(0,length(d$ID))
sex_group1[female_idx] <- 1
d$Sex1 <- sex_group1


svmfit_2nd <- function(dset, title, setidx, karr){
    modelsvm <- svm(x = dset[,karr], y=dset$Age)
    pred = predict(modelsvm, dset[,karr])

    r2 <- R2(dset$Age, pred, form = "traditional")
    rmse <- RMSE(dset$Age, pred)
    mae <- MAE(dset$Age, pred)
    r1<-c(r2, rmse, mae)
    return (r1)
}

# nprotein <- 10

args = (commandArgs(TRUE));
k1 <- as.numeric(args[1])


rst <- c()
# for (k1 in c(5:(nprotein-1) ) ){
    for (k2 in c( (k1+1):nprotein)){
    # jpeg(filename = paste("dist_svm_1st/",cn[k],".jpg",sep=""), width = 900, height = 300, units = "px",pointsize = 15, quality = 90, bg = "white")
    # par(mfrow=c(1,3))
        karr <- c(k1, k2)
        rst_m <- svmfit_2nd(d[male_idx,], "Male", male_idx, karr)
        rst_f <- svmfit_2nd(d[female_idx,], "Female", female_idx, karr)
        rst_a <- svmfit_2nd(d, "All", all_idx, karr)
        rst_as <- svmfit_2nd(d, "All(sex adjusted)", all_idx, c(karr,length(d[1,]) ) ) # sex adjusted
        rst <- rbind(rst, c(paste(cn[karr], collapse=" "), rst_m[1], rst_m[2], rst_m[3], rst_f[1], rst_f[2], rst_f[3], rst_a[1], rst_a[2], rst_a[3], rst_as[1], rst_as[2], rst_as[3]))
    # dev.off()
        cat (k1, k2, '\n')
    }
# }


colnames(rst) <- c('protein_name', 'r2_male', 'rmse_male', 'mae_male', 'r2_female', 'rmse_female','mae_female', 'r2_all', 'rmse_all', 'mae_all', 'r2_all_sex_adjust', 'rmse_all_sex_adjust', 'mae_all_sex_adjust' ) 

# outfile <- "protein_exp_svm_2nd.txt"
outfile <- paste("rst_svm_2nd/", cn[k1] , ".txt", sep="")
write.table(rst, file=outfile, sep="\t", row.names=FALSE, quote=FALSE, append=FALSE)



