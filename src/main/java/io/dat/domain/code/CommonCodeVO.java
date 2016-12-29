package io.dat.domain.code;

import com.chequer.axboot.core.annotations.ColumnPosition;
import com.chequer.axboot.core.code.AXBootTypes;
import com.chequer.axboot.core.utils.ModelMapperUtils;
import com.chequer.axboot.core.vo.BaseVO;
import io.dat.domain.sample.parent.ParentSample;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
public class CommonCodeVO extends BaseVO {

    private String groupCd;

    private String groupNm;

    private String code;

    private String name;

    private Integer sort;

    private String data1;

    private String data2;

    private String data3;

    private Integer data4;

    private Integer data5;

    private String remark;

    private AXBootTypes.Used useYn = AXBootTypes.Used.YES;

    public static CommonCodeVO of(CommonCode commonCode) {
        CommonCodeVO commonCodeVO = ModelMapperUtils.map(commonCode, CommonCodeVO.class);
        return commonCodeVO;
    }

    public static List<CommonCodeVO> of(List<CommonCode> commonCodeList) {
        List<CommonCodeVO> vtoList = new ArrayList<>();

        for (CommonCode object : commonCodeList) {
            vtoList.add(of(object));
        }

        return vtoList;
    }
}
