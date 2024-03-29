#' Create a continuous vector of onsets with a sampling in Hz
#'
#' This is a conversion function that turns onsets into sampled time-series.
#'
#' @param data Data frame to be processed
#' @param sr Sampling rate (default 50 Hz)
#' @param wlen Window length of percentage of the sr
#' @param plot If a plot is needed
#' @param time Time samples to be included in the output
#' @return Output contain vector of onset times
#' @import signal
#' @import ggplot2
#' @import tidyr

gaussify_onsets <- function(data = NULL,
                            sr = 250,
                            wlen = 0.2,
                            plot = FALSE,
                            time = TRUE) {
  
  onsetcurve <- NULL
  X <- Y <- NULL
  # remove NAs
  data <- data[!is.na(data)]
  
  # define time
  mintime <- min(data)
  maxtime <- max(data)
  t <- seq(mintime, (maxtime + 1 / sr), by = 1 / sr) # Time
  signal <- rep(0, 1, length(t))          # Empty vector
  #  length(t)
  #  length(signal)
  
  # add 1 to locations of onsets
  signal[round((data - mintime) * sr) + 1] <- 1
  #  length(signal)
  
  # define the window length
  WLEN <- round(sr * wlen)
  
  # add empty padding around time derived from WLEN
  signal <- c(array(0, WLEN), signal, array(0, WLEN))
  #minbuffer <- seq(mintime - WLEN / sr, mintime - 1 / sr, by = 1 / sr)
  #maxbuffer <- seq(maxtime + 2 / sr, maxtime + WLEN+1 / sr, by = 1 / sr)

  minbuffer <- array(NA, WLEN)
  maxbuffer <- array(NA, WLEN)
  
  t <- c(minbuffer, t, maxbuffer)
 #   length(t)
#    length(signal)
  
  # filter
  fil <- signal::hanning(n = WLEN)
  signalf <- signal::filter(filt = fil, a = 1, x = signal)
  st <- (WLEN * 1)+1  # CHANGED INTO 1 from 2
  signalf_crop <- signalf[(st+round(WLEN/2)):length(signalf)]
  t_crop <- t[st:(length(t)-round(WLEN/2))]
 #   length(signalf_crop)
  #  length(t_crop)
  
  # put time and signal into a data.frame
  signalf_crop_time <-
    data.frame(time = t_crop, onsetcurve = signalf_crop)
  signalf_crop_time <- tidyr::drop_na(signalf_crop_time)
  
  # plot
  if (plot == TRUE) {
    g1 <-
      ggplot2::ggplot(signalf_crop_time, ggplot2::aes(x = time, y = onsetcurve)) +
      ggplot2::geom_line(colour = 'navyblue') +
      ggplot2::scale_x_time() +
      ggplot2::scale_y_continuous(limits = c(0,1),expand = c(0.001,0.001))+
      ggplot2::geom_vline(xintercept = data,colour='red')+
      ggplot2::geom_point(data.frame(X=data,Y=1),mapping=ggplot2::aes(x=X,y=Y),colour='red')+
      ggplot2::xlab('Time') +
      ggplot2::ylab('Onset Density') +
      ggplot2::theme_linedraw()
    print(g1)
    
  }
  # if only signal is needed
  if (time == FALSE) {
    signalf_crop_time <- signalf_crop
  }
  return <- signalf_crop_time
}
