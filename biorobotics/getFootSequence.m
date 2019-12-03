% Function to get the foot sequence

function [output] = getFootSequence(refVectors, jointAgngles, windowSize)
    elementsNum = size(jointAgngles, 1);
    output = [];
    for idx = 1:elementsNum - windowSize
        for idxWin = 1:windowSize
            leftDown(1:3,1:3,idxWin) = calcGlobalPose(refVectors, jointAgngles(idx + idxWin - 1,:), true, MODE_FOOT);
            rightDown(1:3,1:3,idxWin) = calcGlobalPose(refVectors, jointAgngles(idx + idxWin - 1,:), false, MODE_FOOT);
        end
    end
end